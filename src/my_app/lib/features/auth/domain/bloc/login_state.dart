part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required String? emailAddress,
    required Failure? failure,
    required bool isLoading,
    required bool isSuccess,
  }) = _LoginState;

  factory LoginState.initial() => const _LoginState(
        emailAddress: null,
        isLoading: false,
        failure: null,
        isSuccess: false,
      );
}
