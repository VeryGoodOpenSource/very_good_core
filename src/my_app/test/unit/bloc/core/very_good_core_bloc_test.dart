import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:very_good_core/app/constants/enum.dart';
import 'package:very_good_core/core/domain/bloc/very_good_core/very_good_core_bloc.dart';
import 'package:very_good_core/core/domain/interface/i_user_repository.dart';
import 'package:very_good_core/core/domain/model/failures.dart';
import 'package:very_good_core/features/auth/domain/interface/i_auth_repository.dart';

import '../../../utils/test_utils.dart';
import 'very_good_core_bloc_test.mocks.dart';

@GenerateMocks(<Type>[
  IUserRepository,
  VeryGoodCoreBloc,
  IAuthRepository,
])
void main() {
  late MockIUserRepository userRepository;
  late MockIAuthRepository authRepository;
  late VeryGoodCoreBloc veryGoodCoreBloc;

  setUp(() {
    userRepository = MockIUserRepository();
    authRepository = MockIAuthRepository();
    veryGoodCoreBloc = VeryGoodCoreBloc(userRepository, authRepository);
  });

  group('VeryGoodCoreBloc initialize', () {
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => none());

        return veryGoodCoreBloc;
      },
      act: (VeryGoodCoreBloc bloc) => bloc.initialize(),
      expect: () => <dynamic>[
        VeryGoodCoreState.initial().copyWith(isLoading: true),
        veryGoodCoreBloc.state
            .copyWith(authStatus: AuthStatus.unauthenticated, user: null),
      ],
    );

    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit an authenticated with user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => some(mockUser));

        return veryGoodCoreBloc;
      },
      act: (VeryGoodCoreBloc bloc) => bloc.initialize(),
      expect: () => <dynamic>[
        VeryGoodCoreState.initial().copyWith(isLoading: true),
        veryGoodCoreBloc.state
            .copyWith(authStatus: AuthStatus.authenticated, user: mockUser),
      ],
    );
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit a failed state',
      build: () {
        when(userRepository.user).thenThrow(throwsException);

        return veryGoodCoreBloc;
      },
      act: (VeryGoodCoreBloc bloc) => bloc.initialize(),
      expect: () => <dynamic>[
        VeryGoodCoreState.initial().copyWith(isLoading: true),
        veryGoodCoreBloc.state
            .copyWith(failure: Failure.unexpected(throwsException.toString())),
      ],
    );
  });

  group('VeryGoodCoreBloc getUser ', () {
    setUp(() async {
      veryGoodCoreBloc = VeryGoodCoreBloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await veryGoodCoreBloc.initialize();
    });
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => none());

        return veryGoodCoreBloc;
      },
      act: (VeryGoodCoreBloc bloc) => bloc.getUser(),
      expect: () => <dynamic>[
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          isLoading: false,
        ),
      ],
    );

    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit an authenticated with user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => some(mockUser));

        return veryGoodCoreBloc;
      },
      act: (VeryGoodCoreBloc bloc) => bloc.getUser(),
      expect: () => <dynamic>[
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          user: mockUser,
          isLoading: false,
        ),
      ],
    );
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit  a failed state',
      build: () {
        when(userRepository.user).thenThrow(throwsException);

        return veryGoodCoreBloc;
      },
      act: (VeryGoodCoreBloc bloc) => bloc.getUser(),
      expect: () => <dynamic>[
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        veryGoodCoreBloc.state
            .copyWith(failure: Failure.unexpected(throwsException.toString())),
      ],
    );
  });

  group('VeryGoodCoreBloc logout ', () {
    setUp(() async {
      veryGoodCoreBloc = VeryGoodCoreBloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await veryGoodCoreBloc.initialize();
    });
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(authRepository.logout()).thenAnswer((_) async => right(unit));

        return veryGoodCoreBloc;
      },
      act: (VeryGoodCoreBloc bloc) => bloc.logout(),
      expect: () => <dynamic>[
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          isLoading: false,
        ),
      ],
    );
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit a failed state',
      build: () {
        when(authRepository.logout()).thenAnswer(
          (_) async => left(Failure.unexpected(throwsException.toString())),
        );

        return veryGoodCoreBloc;
      },
      act: (VeryGoodCoreBloc bloc) => bloc.logout(),
      expect: () => <dynamic>[
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        veryGoodCoreBloc.state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(throwsException.toString()),
        ),
      ],
    );
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit a failed state when unexpected error occurs',
      build: () {
        when(authRepository.logout()).thenThrow(throwsException);

        return veryGoodCoreBloc;
      },
      act: (VeryGoodCoreBloc bloc) => bloc.logout(),
      expect: () => <dynamic>[
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        veryGoodCoreBloc.state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(throwsException.toString()),
        ),
      ],
    );
  });

  group('VeryGoodCoreBloc authenticate', () {
    setUp(() async {
      veryGoodCoreBloc = VeryGoodCoreBloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await veryGoodCoreBloc.initialize();
    });
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit an authenticated user state',
      build: () => veryGoodCoreBloc,
      act: (VeryGoodCoreBloc bloc) => bloc.authenticate(),
      expect: () => <dynamic>[
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          user: mockUser,
          isLoading: false,
        ),
      ],
    );
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => none());
        when(authRepository.logout()).thenAnswer((_) async => right(unit));

        return veryGoodCoreBloc;
      },
      act: (VeryGoodCoreBloc bloc) => bloc.authenticate(),
      expect: () => <dynamic>[
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          isLoading: false,
        ),
      ],
    );
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit a failed state',
      build: () {
        when(userRepository.user).thenThrow(throwsException);

        return veryGoodCoreBloc;
      },
      act: (VeryGoodCoreBloc bloc) => bloc.authenticate(),
      expect: () => <dynamic>[
        veryGoodCoreBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        veryGoodCoreBloc.state
            .copyWith(failure: Failure.unexpected(throwsException.toString())),
      ],
    );
  });
  group('VeryGoodCoreBloc switchTheme ', () {
    setUp(() async {
      veryGoodCoreBloc = VeryGoodCoreBloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await veryGoodCoreBloc.initialize();
    });
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit a dark theme mode',
      build: () => veryGoodCoreBloc,
      act: (VeryGoodCoreBloc bloc) async => bloc.switchTheme(Brightness.light),
      expect: () => <dynamic>[
        veryGoodCoreBloc.state.copyWith(themeMode: ThemeMode.dark),
      ],
    );
    blocTest<VeryGoodCoreBloc, VeryGoodCoreState>(
      'should emit a light theme mode',
      build: () => veryGoodCoreBloc,
      act: (VeryGoodCoreBloc bloc) async => bloc.switchTheme(Brightness.dark),
      expect: () => <dynamic>[
        veryGoodCoreBloc.state.copyWith(themeMode: ThemeMode.light),
      ],
    );
  });
}
