part of '{{project_name.snakeCase()}}_bloc.dart';

@freezed
class {{#pascalCase}}{{project_name}}{{/pascalCase}}State with _${{#pascalCase}}{{project_name}}{{/pascalCase}}State {
  factory {{#pascalCase}}{{project_name}}{{/pascalCase}}State({
    required AuthStatus authStatus,
    required ThemeMode themeMode,
    required bool isLoading,
    Failure? failure,
    User? user,
  }) = _{{#pascalCase}}{{project_name}}{{/pascalCase}}State;

  factory {{#pascalCase}}{{project_name}}{{/pascalCase}}State.initial() => _{{#pascalCase}}{{project_name}}{{/pascalCase}}State(
        authStatus: AuthStatus.unknown,
        themeMode: ThemeMode.system,
        isLoading: false,
      );
}
