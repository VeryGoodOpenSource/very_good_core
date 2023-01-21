import 'dart:async';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/interface/i_local_storage_repository.dart';

abstract class _Keys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String emailAddress = 'email_address';
}

@LazySingleton(as: ILocalStorageRepository)
class LocalStorageRepository implements ILocalStorageRepository {
  const LocalStorageRepository(
    this._securedStorage,
    this._unsecuredStorage,
  );

  final FlutterSecureStorage _securedStorage;
  final SharedPreferences _unsecuredStorage;

  /// Secured Storage services
  @override
  Future<String?> getAccessToken() =>
      _securedStorage.read(key: _Keys.accessToken);
  @override
  Future<bool> setAccessToken(String? value) async {
    try {
      await _securedStorage.write(key: _Keys.accessToken, value: value);

      return true;
    } catch (error) {
      log(error.toString());

      return false;
    }
  }

  @override
  Future<String?> getRefreshToken() =>
      _securedStorage.read(key: _Keys.refreshToken);
  @override
  Future<bool> setRefreshToken(String? value) async {
    try {
      await _securedStorage.write(key: _Keys.refreshToken, value: value);

      return true;
    } catch (error) {
      log(error.toString());

      return false;
    }
  }

  /// Unsecured storage services
  @override
  Future<String?> getLastLoggedInEmail() async =>
      _unsecuredStorage.getString(_Keys.emailAddress);
  @override
  Future<bool> setLastLoggedInEmail(String? value) async {
    try {
      return _unsecuredStorage.setString(_Keys.emailAddress, value ?? '');
    } catch (error) {
      log(error.toString());

      return false;
    }
  }
}
