import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:very_good_core/core/data/repository/local_storage_repository.dart';
import 'package:very_good_core/core/domain/model/failures.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';
import 'package:very_good_core/features/auth/data/model/login_response.dto.dart';
import 'package:very_good_core/features/auth/data/repository/auth_repository.dart';
import 'package:very_good_core/features/auth/data/service/auth_service.dart';

import '../../../../utils/test_utils.dart';
import 'auth_repository_test.mocks.dart';

@GenerateMocks(<Type>[AuthService, LocalStorageRepository])
void main() {
  late MockAuthService authService;
  late MockLocalStorageRepository localStorageRepository;
  late AuthRepository authRepository;
  late LoginResponseDTO loginResponseDTO;

  setUp(() {
    authService = MockAuthService();
    localStorageRepository = MockLocalStorageRepository();
    authRepository = AuthRepository(authService, localStorageRepository);
    loginResponseDTO = const LoginResponseDTO(accessToken: 'accessToken');
  });

  group('Login', () {
    test(
      'should return a unit when login is successful',
      () async {
        // arrange
        when(authService.login(any)).thenAnswer(
          (_) async =>
              generateMockResponse<LoginResponseDTO>(loginResponseDTO, 200),
        );
        when(localStorageRepository.setAccessToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setRefreshToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setLastLoggedInEmail(any))
            .thenAnswer((_) async => true);
        // act
        final Either<Failure, Unit> result = await authRepository.login(
          EmailAddress('email@example.com'),
          Password('password'),
        );
        // assert
        expect(result.isRight(), true);
      },
    );

    test(
      'should return a failure when login encounters a server error',
      () async {
        // arrange
        when(authService.login(any)).thenAnswer(
          (_) async =>
              generateMockResponse<LoginResponseDTO>(loginResponseDTO, 500),
        );
        when(localStorageRepository.setAccessToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setRefreshToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setLastLoggedInEmail(any))
            .thenAnswer((_) async => true);
        // act
        final Either<Failure, Unit> result = await authRepository.login(
          EmailAddress('email@example.com'),
          Password('password'),
        );
        // assert
        expect(result.isLeft(), true);
      },
    );

    test(
      'should return a failure when login encounters an unexpected error',
      () async {
        // arrange
        when(authService.login(any)).thenThrow(throwsException);
        when(localStorageRepository.setAccessToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setRefreshToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setLastLoggedInEmail(any))
            .thenAnswer((_) async => true);
        // act
        final Either<Failure, Unit> result = await authRepository.login(
          EmailAddress('email@example.com'),
          Password('password'),
        );
        // assert
        expect(result.isLeft(), true);
      },
    );
    test(
      'should return a failure when an error occurs when saving the access token',
      () async {
        // arrange
        when(authService.login(any)).thenAnswer(
          (_) async =>
              generateMockResponse<LoginResponseDTO>(loginResponseDTO, 200),
        );
        when(localStorageRepository.setAccessToken(any))
            .thenAnswer((_) async => false);
        when(localStorageRepository.setRefreshToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setLastLoggedInEmail(any))
            .thenAnswer((_) async => true);
        // act
        final Either<Failure, Unit> result = await authRepository.login(
          EmailAddress('email@example.com'),
          Password('password'),
        );
        // assert
        expect(result.isLeft(), true);
      },
    );
    test(
      'should return a failure when an error occurs when saving the refresh token',
      () async {
        // arrange
        when(authService.login(any)).thenAnswer(
          (_) async =>
              generateMockResponse<LoginResponseDTO>(loginResponseDTO, 200),
        );
        when(localStorageRepository.setAccessToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setRefreshToken(any))
            .thenAnswer((_) async => false);
        when(localStorageRepository.setLastLoggedInEmail(any))
            .thenAnswer((_) async => true);
        // act
        final Either<Failure, Unit> result = await authRepository.login(
          EmailAddress('email@example.com'),
          Password('password'),
        );
        // assert
        expect(result.isLeft(), true);
      },
    );
    test(
      'should return a failure when an error occurs when saving the last logged in email',
      () async {
        // arrange
        when(authService.login(any)).thenAnswer(
          (_) async =>
              generateMockResponse<LoginResponseDTO>(loginResponseDTO, 200),
        );
        when(localStorageRepository.setAccessToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setRefreshToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setLastLoggedInEmail(any))
            .thenAnswer((_) async => false);
        // act
        final Either<Failure, Unit> result = await authRepository.login(
          EmailAddress('email@example.com'),
          Password('password'),
        );
        // assert
        expect(result.isLeft(), true);
      },
    );
  });
  group('Logout', () {
    test(
      'should return a unit when logout is successful',
      () async {
        // arrange
        when(localStorageRepository.setAccessToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setRefreshToken(any))
            .thenAnswer((_) async => true);
        // act
        final Either<Failure, Unit> result = await authRepository.logout();
        // assert
        expect(result.isRight(), true);
      },
    );

    test(
      'should return a failure when logout encounters an unexpected error',
      () async {
        // arrange
        when(localStorageRepository.setAccessToken(any))
            .thenThrow(throwsException);
        when(localStorageRepository.setRefreshToken(any))
            .thenAnswer((_) async => true);
        // act
        final Either<Failure, Unit> result = await authRepository.logout();
        // assert
        expect(result.isLeft(), true);
      },
    );
    test(
      'should return a failure when an error occurs when clearing the access token',
      () async {
        // arrange
        when(localStorageRepository.setAccessToken(any))
            .thenAnswer((_) async => false);
        when(localStorageRepository.setRefreshToken(any))
            .thenAnswer((_) async => true);
        // act
        final Either<Failure, Unit> result = await authRepository.logout();
        // assert
        expect(result.isLeft(), true);
      },
    );
    test(
      'should return a failure when an error occurs when clearing the refresh token',
      () async {
        // arrange
        when(localStorageRepository.setAccessToken(any))
            .thenAnswer((_) async => true);
        when(localStorageRepository.setRefreshToken(any))
            .thenAnswer((_) async => false);
        // act
        final Either<Failure, Unit> result = await authRepository.logout();
        // assert
        expect(result.isLeft(), true);
      },
    );
  });
}
