import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';
import 'package:very_good_core/app/constants/constant.dart';
import 'package:very_good_core/app/constants/enum.dart';
import 'package:very_good_core/app/utils/extensions.dart';

@lazySingleton
class ConnectivityUtils {
  ConnectivityUtils() {
    _checkInternetConnection();
  }

  final Connectivity _connectivity = Connectivity();
  final BehaviorSubject<ConnectionStatus> _controller =
      BehaviorSubject<ConnectionStatus>.seeded(ConnectionStatus.online);
  StreamSubscription<ConnectivityResult>? _connectionSubscription;
  ConnectionStatus _currentStatus = ConnectionStatus.online;
  bool get isConnected => _currentStatus == ConnectionStatus.online;
  bool get isNotConnected => !isConnected;

  Stream<ConnectionStatus> internetStatus() {
    _connectionSubscription ??= _connectivity.onConnectivityChanged
        .listen((_) => _checkInternetConnection());

    return _controller.stream;
  }

  Future<void> _checkInternetConnection() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    _updateStatus(await checkInternet());
  }

  Future<ConnectionStatus> checkInternet() async {
    try {
      final Either<List<InternetAddress>, http.Response> result = kIsWeb //
          ? right(await http.get(Uri.parse(Constant.networkLookup)))
          : left(await InternetAddress.lookup(Constant.networkLookup));

      return result.fold(
        (List<InternetAddress> mobile) =>
            mobile.isNotEmpty && mobile.first.rawAddress.isNotEmpty //
                ? ConnectionStatus.online
                : ConnectionStatus.offline,
        (http.Response web) => web.statusCode.statusCode.isSuccess //
            ? ConnectionStatus.online
            : ConnectionStatus.offline,
      );
    } on SocketException catch (_) {
      return ConnectionStatus.offline;
    }
  }

  void _updateStatus(ConnectionStatus status) {
    _currentStatus = status;
    _controller.sink.add(status);
  }

  Future<void> close() async {
    await _connectionSubscription?.cancel();
    await _controller.close();
  }
}
