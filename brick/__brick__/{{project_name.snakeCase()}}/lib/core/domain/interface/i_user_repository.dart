import 'package:dartz/dartz.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/user.dart';

abstract class IUserRepository {
  Future<Option<User>> get user;
}
