import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/enum.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/interface/i_user_repository.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/failures.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/user.dart';
import 'package:{{project_name.snakeCase()}}/features/auth/domain/interface/i_auth_repository.dart';

part '{{project_name.snakeCase()}}_bloc.freezed.dart';
part '{{project_name.snakeCase()}}_state.dart';

@lazySingleton
class {{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc extends Cubit<{{#pascalCase}}{{project_name}}{{/pascalCase}}State> {
  {{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc(
    this._userRepository,
    this._authRepository,
  ) : super({{#pascalCase}}{{project_name}}{{/pascalCase}}State.initial()) {
    initialize();
  }

  final IUserRepository _userRepository;
  final IAuthRepository _authRepository;

  Future<void> initialize() async {
    await checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    try {
      emit(state.copyWith(isLoading: true, failure: null));
      final Option<User> user = await _userRepository.user;
      emit(
        user.fold(
          () => state.copyWith(
            authStatus: AuthStatus.unauthenticated,
            user: null,
            isLoading: false,
          ),
          (User user) => state.copyWith(
            authStatus: AuthStatus.authenticated,
            user: user,
            isLoading: false,
          ),
        ),
      );
    } catch (error) {
      log(error.toString());
      emit(
        state.copyWith(
          failure: Failure.unexpected(error.toString()),
          isLoading: false,
        ),
      );
    }
  }

  Future<void> getUser() async {
    try {
      emit(state.copyWith(isLoading: true, failure: null));
      final Option<User> user = await _userRepository.user;

      emit(
        user.fold(
          () => state.copyWith(
            user: null,
            authStatus: AuthStatus.unauthenticated,
            isLoading: false,
          ),
          (User user) => state.copyWith(
            authStatus: AuthStatus.authenticated,
            user: user,
            isLoading: false,
          ),
        ),
      );
    } catch (error) {
      log(error.toString());
      emit(
        state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(error.toString()),
        ),
      );
    }
  }

  Future<void> logout({bool isLoading = false}) async {
    try {
      if (!isLoading) {
        emit(state.copyWith(isLoading: true, failure: null));
      }
      final Either<Failure, Unit> possibleFailure =
          await _authRepository.logout();

      emit(
        possibleFailure.fold(
          (Failure failure) =>
              state.copyWith(isLoading: false, failure: failure),
          (_) => state.copyWith(
            authStatus: AuthStatus.unauthenticated,
            user: null,
            isLoading: false,
          ),
        ),
      );
    } catch (error) {
      log(error.toString());
      emit(
        state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(error.toString()),
        ),
      );
    }
  }

  void switchTheme(Brightness brightness) => emit(
        state.copyWith(
          themeMode: brightness == Brightness.dark //
              ? ThemeMode.light
              : ThemeMode.dark,
        ),
      );

  Future<void> authenticate() async {
    try {
      emit(state.copyWith(isLoading: true, failure: null));

      final Option<User> user = await _userRepository.user;
      await user.fold(
        () async => logout(
          isLoading: true,
        ), // logout if there is no user found, isLoading is true since current state is still in loading
        (User user) async => emit(
          state.copyWith(
            authStatus: AuthStatus.authenticated,
            user: user,
            isLoading: false,
          ),
        ),
      );
    } catch (error) {
      log(error.toString());
      emit(
        state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(error.toString()),
        ),
      );
    }
  }
}
