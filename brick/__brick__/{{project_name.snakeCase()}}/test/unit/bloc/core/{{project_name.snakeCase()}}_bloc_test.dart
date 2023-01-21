import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{project_name.snakeCase()}}/app/constants/enum.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/bloc/{{project_name.snakeCase()}}/{{project_name.snakeCase()}}_bloc.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/interface/i_user_repository.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/failures.dart';
import 'package:{{project_name.snakeCase()}}/features/auth/domain/interface/i_auth_repository.dart';

import '../../../utils/test_utils.dart';
import '{{project_name.snakeCase()}}_bloc_test.mocks.dart';

@GenerateMocks(<Type>[
  IUserRepository,
  {{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc,
  IAuthRepository,
])
void main() {
  late MockIUserRepository userRepository;
  late MockIAuthRepository authRepository;
  late {{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;

  setUp(() async {
    userRepository = MockIUserRepository();
    authRepository = MockIAuthRepository();
    {{#camelCase}}{{project_name}}{{/camelCase}}Bloc = {{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc(userRepository, authRepository);
  });

  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc initialize', () {
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => none());

        return {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
      },
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) => bloc.initialize(),
      expect: () => <dynamic>[
        {{#pascalCase}}{{project_name}}{{/pascalCase}}State.initial().copyWith(isLoading: true),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state
            .copyWith(authStatus: AuthStatus.unauthenticated, user: null),
      ],
    );

    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit an authenticated with user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => some(mockUser));

        return {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
      },
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) => bloc.initialize(),
      expect: () => <dynamic>[
        {{#pascalCase}}{{project_name}}{{/pascalCase}}State.initial().copyWith(isLoading: true),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state
            .copyWith(authStatus: AuthStatus.authenticated, user: mockUser),
      ],
    );
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit a failed state',
      build: () {
        when(userRepository.user).thenThrow(throwsException);

        return {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
      },
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) => bloc.initialize(),
      expect: () => <dynamic>[
        {{#pascalCase}}{{project_name}}{{/pascalCase}}State.initial().copyWith(isLoading: true),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state
            .copyWith(failure: Failure.unexpected(throwsException.toString())),
      ],
    );
  });

  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc getUser ', () {
    setUp(() async {
      {{#camelCase}}{{project_name}}{{/camelCase}}Bloc = {{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.initialize();
    });
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => none());

        return {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
      },
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) async => bloc.getUser(),
      expect: () => <dynamic>[
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          isLoading: false,
        ),
      ],
    );

    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit an authenticated with user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => some(mockUser));

        return {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
      },
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) async => bloc.getUser(),
      expect: () => <dynamic>[
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          user: mockUser,
          isLoading: false,
        ),
      ],
    );
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit  a failed state',
      build: () {
        when(userRepository.user).thenThrow(throwsException);

        return {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
      },
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) async => bloc.getUser(),
      expect: () => <dynamic>[
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state
            .copyWith(failure: Failure.unexpected(throwsException.toString())),
      ],
    );
  });

  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc logout ', () {
    setUp(() async {
      {{#camelCase}}{{project_name}}{{/camelCase}}Bloc = {{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.initialize();
    });
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(authRepository.logout()).thenAnswer((_) async => right(unit));

        return {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
      },
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) async => bloc.logout(),
      expect: () => <dynamic>[
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          isLoading: false,
        ),
      ],
    );
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit a failed state',
      build: () {
        when(authRepository.logout()).thenAnswer(
          (_) async => left(Failure.unexpected(throwsException.toString())),
        );

        return {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
      },
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) async => bloc.logout(),
      expect: () => <dynamic>[
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(throwsException.toString()),
        ),
      ],
    );
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit a failed state when unexpected error occurs',
      build: () {
        when(authRepository.logout()).thenThrow(throwsException);

        return {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
      },
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) async => bloc.logout(),
      expect: () => <dynamic>[
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(throwsException.toString()),
        ),
      ],
    );
  });

  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc authenticate', () {
    setUp(() async {
      {{#camelCase}}{{project_name}}{{/camelCase}}Bloc = {{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.initialize();
    });
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit an authenticated user state',
      build: () => {{#camelCase}}{{project_name}}{{/camelCase}}Bloc,
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) async => bloc.authenticate(),
      expect: () => <dynamic>[
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          user: mockUser,
          isLoading: false,
        ),
      ],
    );
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => none());
        when(authRepository.logout()).thenAnswer((_) async => right(unit));

        return {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
      },
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) async => bloc.authenticate(),
      expect: () => <dynamic>[
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          isLoading: false,
        ),
      ],
    );
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit a failed state',
      build: () {
        when(userRepository.user).thenThrow(throwsException);

        return {{#camelCase}}{{project_name}}{{/camelCase}}Bloc;
      },
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) async => bloc.authenticate(),
      expect: () => <dynamic>[
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state
            .copyWith(failure: Failure.unexpected(throwsException.toString())),
      ],
    );
  });
  group('{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc switchTheme ', () {
    setUp(() async {
      {{#camelCase}}{{project_name}}{{/camelCase}}Bloc = {{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.initialize();
    });
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit a dark theme mode',
      build: () => {{#camelCase}}{{project_name}}{{/camelCase}}Bloc,
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) async => bloc.switchTheme(Brightness.light),
      expect: () => <dynamic>[
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(themeMode: ThemeMode.dark),
      ],
    );
    blocTest<{{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc, {{#pascalCase}}{{project_name}}{{/pascalCase}}State>(
      'should emit a light theme mode',
      build: () => {{#camelCase}}{{project_name}}{{/camelCase}}Bloc,
      act: ({{#pascalCase}}{{project_name}}{{/pascalCase}}Bloc bloc) async => bloc.switchTheme(Brightness.dark),
      expect: () => <dynamic>[
        {{#camelCase}}{{project_name}}{{/camelCase}}Bloc.state.copyWith(themeMode: ThemeMode.light),
      ],
    );
  });
}
