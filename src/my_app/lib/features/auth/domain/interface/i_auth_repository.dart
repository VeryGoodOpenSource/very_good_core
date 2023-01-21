import 'package:dartz/dartz.dart';
import 'package:very_good_core/core/domain/model/failures.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';

abstract class IAuthRepository {
  Future<Either<Failure, Unit>> login(EmailAddress email, Password password);

  Future<Either<Failure, Unit>> logout();
}
