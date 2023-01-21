import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:very_good_core/app/constants/enum.dart';
import 'package:very_good_core/core/domain/interface/i_local_storage_repository.dart';
import 'package:very_good_core/core/domain/model/failures.dart';
import 'package:very_good_core/features/auth/domain/bloc/login_bloc.dart';
import 'package:very_good_core/features/auth/domain/interface/i_auth_repository.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks(<Type>[IAuthRepository, ILocalStorageRepository])
void main() {
  late MockIAuthRepository authRepository;
  late MockILocalStorageRepository localStorageRepository;
  late LoginBloc loginBloc;
  late String email;
  late String password;
  late Failure failure;

  setUp(() async {
    authRepository = MockIAuthRepository();
    localStorageRepository = MockILocalStorageRepository();

    email = 'email@example.com';
    password = 'password';
  });

  group('LoginBloc initialize', () {
    blocTest<LoginBloc, LoginState>(
      'should emit an null email address',
      build: () {
        when(localStorageRepository.getLastLoggedInEmail())
            .thenAnswer((_) async => null);

        return LoginBloc(authRepository, localStorageRepository);
      },
      act: (LoginBloc bloc) async => bloc.initialize(),
      expect: () => <dynamic>[LoginState.initial()],
    );

    blocTest<LoginBloc, LoginState>(
      'should emit an email address',
      build: () {
        when(localStorageRepository.getLastLoggedInEmail())
            .thenAnswer((_) async => email);

        return LoginBloc(authRepository, localStorageRepository);
      },
      act: (LoginBloc bloc) async => bloc.initialize(),
      expect: () =>
          <dynamic>[LoginState.initial().copyWith(emailAddress: email)],
    );
  });

  group('LoginBloc onEmailAddressChanged', () {
    setUp(() async {
      when(localStorageRepository.getLastLoggedInEmail())
          .thenAnswer((_) async => null);
      loginBloc = LoginBloc(authRepository, localStorageRepository);
    });
    blocTest<LoginBloc, LoginState>(
      'should emit an the new email address',
      build: () => loginBloc,
      act: (LoginBloc bloc) async => bloc.onEmailAddressChanged('test_$email'),
      expect: () => <dynamic>[
        loginBloc.state.copyWith(emailAddress: 'test_$email'),
      ],
    );
  });

  group('LoginBloc login', () {
    setUp(() async {
      when(localStorageRepository.getLastLoggedInEmail())
          .thenAnswer((_) async => null);
      loginBloc = LoginBloc(authRepository, localStorageRepository);
      failure =
          const Failure.serverError(StatusCode.api500, 'INTERNAL SERVER ERROR');
    });
    blocTest<LoginBloc, LoginState>(
      'should emit an the a success state',
      build: () {
        when(authRepository.login(any, any))
            .thenAnswer((_) async => right(unit));

        return loginBloc;
      },
      act: (LoginBloc bloc) async => bloc.login(email, password),
      expect: () => <dynamic>[
        loginBloc.state.copyWith(isLoading: true, isSuccess: false),
        loginBloc.state.copyWith(isSuccess: true, isLoading: false),
      ],
    );
    blocTest<LoginBloc, LoginState>(
      'should emit a failed state',
      build: () {
        when(authRepository.login(any, any))
            .thenAnswer((_) async => left(failure));

        return loginBloc;
      },
      act: (LoginBloc bloc) async => bloc.login(email, password),
      expect: () => <dynamic>[
        loginBloc.state.copyWith(isLoading: true, isSuccess: false),
        loginBloc.state
            .copyWith(isSuccess: false, isLoading: false, failure: failure),
        loginBloc.state
            .copyWith(isSuccess: false, isLoading: false, failure: null),
      ],
    );
    blocTest<LoginBloc, LoginState>(
      'should emit a unexpected error state',
      build: () {
        when(authRepository.login(any, any)).thenThrow(throwsException);

        return loginBloc;
      },
      act: (LoginBloc bloc) async => bloc.login(email, password),
      expect: () => <dynamic>[
        loginBloc.state.copyWith(isLoading: true, isSuccess: false),
        loginBloc.state.copyWith(
          isSuccess: false,
          isLoading: false,
          failure: Failure.unexpected(throwsException.toString()),
        ),
        loginBloc.state
            .copyWith(isSuccess: false, isLoading: false, failure: null),
      ],
    );
    blocTest<LoginBloc, LoginState>(
      'should emit an invalid email error state',
      build: () {
        when(authRepository.login(any, any)).thenThrow(throwsException);

        return loginBloc;
      },
      act: (LoginBloc bloc) async => bloc.login('email', password),
      expect: () => <dynamic>[
        loginBloc.state.copyWith(isLoading: true, isSuccess: false),
        loginBloc.state.copyWith(
          isSuccess: false,
          isLoading: false,
          failure: const Failure.invalidEmailFormat(),
        ),
        loginBloc.state
            .copyWith(isSuccess: false, isLoading: false, failure: null),
      ],
    );
    blocTest<LoginBloc, LoginState>(
      'should emit an invalid password error state',
      build: () {
        when(authRepository.login(any, any)).thenThrow(throwsException);

        return loginBloc;
      },
      act: (LoginBloc bloc) async => bloc.login(email, 'pass'),
      expect: () => <dynamic>[
        loginBloc.state.copyWith(isLoading: true, isSuccess: false),
        loginBloc.state.copyWith(
          isSuccess: false,
          isLoading: false,
          failure: const Failure.exceedingCharacterLength(min: 6),
        ),
        loginBloc.state
            .copyWith(isSuccess: false, isLoading: false, failure: null),
      ],
    );
  });
}
