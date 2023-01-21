import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:{{project_name.snakeCase()}}/app/utils/extensions.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/interface/i_local_storage_repository.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/failures.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/value_objects.dart';
import 'package:{{project_name.snakeCase()}}/features/auth/domain/interface/i_auth_repository.dart';

part 'login_bloc.freezed.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Cubit<LoginState> {
  LoginBloc(
    this._authRepository,
    this._localStorageRepository,
  ) : super(LoginState.initial()) {
    initialize();
  }

  final IAuthRepository _authRepository;
  final ILocalStorageRepository _localStorageRepository;

  Future<void> initialize() async {
    final String? email = await _localStorageRepository.getLastLoggedInEmail();
    emit(state.copyWith(emailAddress: email));
  }

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(isLoading: true, failure: null));
      final EmailAddress validEmail = EmailAddress(email);
      final Password validPassword = Password(password);
      final bool isValidEmail = validEmail.isValid();
      final bool isValidPassword = validPassword.isValid();

      if (isValidEmail && isValidPassword) {
        final Either<Failure, Unit> possibleFailure =
            await _authRepository.login(validEmail, validPassword);
        emit(
          possibleFailure.fold(
            (Failure failure) =>
                state.copyWith(isLoading: false, failure: failure),
            (_) => state.copyWith(isLoading: false, isSuccess: true),
          ),
        );
      } else {
        if (!isValidEmail) {
          emit(
            state.copyWith(
              isLoading: false,
              failure: validEmail.value.asLeft(),
            ),
          );
        } else if (!isValidPassword) {
          emit(
            state.copyWith(
              isLoading: false,
              failure: validPassword.value.asLeft(),
            ),
          );
        }
      }
    } catch (error) {
      log(error.toString());

      emit(
        state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(error.toString()),
        ),
      );
    }
    //Clear error message
    emit(state.copyWith(failure: null));
  }

  void onEmailAddressChanged(String emailAddress) =>
      emit(state.copyWith(emailAddress: emailAddress));
}
