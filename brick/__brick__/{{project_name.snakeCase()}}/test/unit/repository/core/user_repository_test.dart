import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:{{project_name.snakeCase()}}/core/data/model/user.dto.dart';
import 'package:{{project_name.snakeCase()}}/core/data/repository/user_repository.dart';
import 'package:{{project_name.snakeCase()}}/core/data/service/user_service.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/user.dart';

import '../../../utils/test_utils.dart';
import 'user_repository_test.mocks.dart';

@GenerateMocks(<Type>[UserService])
void main() {
  late UserService userService;
  late UserRepository userRepository;
  late UserDTO user;

  setUp(() {
    userService = MockUserService();
    userRepository = UserRepository(userService);
    user = UserDTO.fromDomain(mockUser);
  });

  group('User', () {
    test(
      'should return some valid user',
      () async {
        // arrange
        final Map<String, dynamic> data = <String, dynamic>{
          'data': user.toJson(),
        };
        when(userService.getCurrentUser()).thenAnswer(
          (_) async => generateMockResponse<Map<String, dynamic>>(data, 200),
        );
        // act
        final Option<User> userRepo = await userRepository.user;
        // assert
        expect(userRepo.isSome(), true);
      },
    );

    test(
      'should return none when an invalid user is returned',
      () async {
        // arrange
        final UserDTO invalidUser = user.copyWith(email: 'email');
        final Map<String, dynamic> data = <String, dynamic>{
          'data': invalidUser.toJson(),
        };
        when(userService.getCurrentUser()).thenAnswer(
          (_) async => generateMockResponse<Map<String, dynamic>>(data, 200),
        );
        // act
        final Option<User> userRepo = await userRepository.user;
        // assert
        expect(userRepo.isNone(), true);
      },
    );

    test(
      'should return none when an server error is encountered',
      () async {
        // arrange
        final Map<String, dynamic> data = <String, dynamic>{'data': ''};
        when(userService.getCurrentUser()).thenAnswer(
          (_) async => generateMockResponse<Map<String, dynamic>>(data, 500),
        );
        // act
        final Option<User> userRepo = await userRepository.user;
        // assert
        expect(userRepo.isNone(), true);
      },
    );

    test(
      'should return none when an unexpected error occurs',
      () async {
        // arrange
        when(userService.getCurrentUser()).thenThrow(throwsException);
        // act
        final Option<User> userRepo = await userRepository.user;
        // assert
        expect(userRepo.isNone(), true);
      },
    );
  });
}
