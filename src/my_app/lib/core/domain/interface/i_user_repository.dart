import 'package:dartz/dartz.dart';
import 'package:very_good_core/core/domain/model/user.dart';

abstract class IUserRepository {
  Future<Option<User>> get user;
}
