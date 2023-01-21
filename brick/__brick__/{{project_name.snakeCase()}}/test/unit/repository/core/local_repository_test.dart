import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:{{project_name.snakeCase()}}/core/data/repository/local_storage_repository.dart';

import 'local_repository_test.mocks.dart';

@GenerateMocks(<Type>[SharedPreferences, FlutterSecureStorage])
void main() {
  late MockSharedPreferences unsecuredStorage;
  late MockFlutterSecureStorage secureStorage;
  late LocalStorageRepository localStorageRepository;

  setUp(() {
    unsecuredStorage = MockSharedPreferences();
    secureStorage = MockFlutterSecureStorage();
    localStorageRepository =
        LocalStorageRepository(secureStorage, unsecuredStorage);
  });

  group('Secure Storage', () {
    group('access token', () {
      test(
        'should return the access token',
        () async {
          // arrange
          const String matcher = 'accessToken';
          when(secureStorage.read(key: 'access_token'))
              .thenAnswer((_) async => matcher);
          // act
          final String? accessToken =
              await localStorageRepository.getAccessToken();
          // assert
          expect(accessToken, matcher);
        },
      );
      test(
        'should return true if the access token is saved successfully',
        () async {
          // arrange
          when(
            secureStorage.write(
              key: 'access_token',
              value: anyNamed('value'),
            ),
          ).thenAnswer((_) async => true);
          // act
          final bool result =
              await localStorageRepository.setAccessToken('access_token');
          // assert
          expect(result, true);
        },
      );
      test(
        'should return false if an unexpected error occurs when saving',
        () async {
          // arrange
          when(
            secureStorage.write(
              key: 'access_token',
              value: anyNamed('value'),
            ),
          ).thenThrow(throwsException);
          // act
          final bool result =
              await localStorageRepository.setAccessToken('access_token');
          // assert
          expect(result, false);
        },
      );
    });

    group('refresh token', () {
      test(
        'should return the refresh token',
        () async {
          // arrange
          const String matcher = 'refreshToken';
          when(secureStorage.read(key: 'refresh_token'))
              .thenAnswer((_) async => matcher);
          // act
          final String? refreshToken =
              await localStorageRepository.getRefreshToken();
          // assert
          expect(refreshToken, matcher);
        },
      );
      test(
        'should return true if the refresh token is saved',
        () async {
          // arrange
          when(
            secureStorage.write(
              key: 'refresh_token',
              value: anyNamed('value'),
            ),
          ).thenAnswer((_) async => true);
          // act
          final bool result =
              await localStorageRepository.setRefreshToken('refresh_token');
          // assert
          expect(result, true);
        },
      );
      test(
        'should return false if an unexpected error occurs when saving',
        () async {
          // arrange
          when(
            secureStorage.write(
              key: 'refresh_token',
              value: anyNamed('value'),
            ),
          ).thenThrow(throwsException);
          // act
          final bool result =
              await localStorageRepository.setRefreshToken('refresh_token');
          // assert
          expect(result, false);
        },
      );
    });
  });

  group('Unsecure Storage', () {
    group('last logged in email', () {
      test(
        'should return the last logged in email',
        () async {
          // arrange
          const String matcher = 'email@example.com';
          when(unsecuredStorage.getString('email_address')).thenReturn(matcher);
          // act
          final String? lastLoggedInEmail =
              await localStorageRepository.getLastLoggedInEmail();
          // assert
          expect(lastLoggedInEmail, matcher);
        },
      );
      test(
        'should return true if the refresh token is saved',
        () async {
          // arrange
          when(unsecuredStorage.setString('email_address', any))
              .thenAnswer((_) async => true);
          // act
          final bool result = await localStorageRepository
              .setLastLoggedInEmail('email@example.com');
          // assert
          expect(result, true);
        },
      );
      test(
        'should return false if an unexpected error occurs when saving',
        () async {
          // arrange
          when(unsecuredStorage.setString('email_address', any))
              .thenThrow(throwsException);
          // act
          final bool result = await localStorageRepository
              .setLastLoggedInEmail('email@example.com');
          // assert
          expect(result, false);
        },
      );
    });
  });
}
