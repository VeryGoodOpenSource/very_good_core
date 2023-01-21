import 'dart:async';

import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/enum.dart';
import 'package:{{project_name.snakeCase()}}/app/utils/connectivity_utils.dart';
import 'package:{{project_name.snakeCase()}}/app/utils/dialog_utils.dart';
import 'package:{{project_name.snakeCase()}}/app/utils/injection.dart';

class ConnectivityChecker extends StatefulWidget {
  const ConnectivityChecker({super.key, required this.child});

  final Widget child;

  static Widget scaffold({
    required Widget body,
    Color? backgroundColor,
  }) =>
      ConnectivityChecker(
        child: Scaffold(
          body: SafeArea(child: body),
          backgroundColor: backgroundColor,
        ),
      );

  @override
  State<ConnectivityChecker> createState() => _ConnectivityCheckerState();
}

class _ConnectivityCheckerState extends State<ConnectivityChecker> {
  StreamSubscription<ConnectionStatus>? _connectionSubscription;
  bool _isDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    final ConnectivityUtils connectivityUtils = getIt<ConnectivityUtils>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await connectivityUtils.checkInternet() == ConnectionStatus.offline &&
          !_isDialogShowing) {
        _isDialogShowing = true;
        await DialogUtils.showOfflineDialog(context);
        _isDialogShowing = false;
      }

      _connectionSubscription ??= connectivityUtils
          .internetStatus()
          .listen((ConnectionStatus event) async {
        if (event == ConnectionStatus.offline && !_isDialogShowing) {
          _isDialogShowing = true;
          await DialogUtils.showOfflineDialog(context);
          _isDialogShowing = false;
        }
      });
    });

    return widget.child;
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    super.dispose();
  }
}
