part of 'very_good_core_bloc.dart';

@freezed
class VeryGoodCoreState with _$VeryGoodCoreState {
  factory VeryGoodCoreState({
    required AuthStatus authStatus,
    required ThemeMode themeMode,
    required bool isLoading,
    Failure? failure,
    User? user,
  }) = _VeryGoodCoreState;

  factory VeryGoodCoreState.initial() => _VeryGoodCoreState(
        authStatus: AuthStatus.unknown,
        themeMode: ThemeMode.system,
        isLoading: false,
      );
}
