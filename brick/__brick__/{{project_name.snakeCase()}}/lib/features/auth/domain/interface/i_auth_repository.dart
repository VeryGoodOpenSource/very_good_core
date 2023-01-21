import 'package:dartz/dartz.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/failures.dart';
import 'package:{{project_name.snakeCase()}}/core/domain/model/value_objects.dart';

abstract class IAuthRepository {
  Future<Either<Failure, Unit>> login(EmailAddress email, Password password);

  Future<Either<Failure, Unit>> logout();
}
