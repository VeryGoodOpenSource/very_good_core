import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:very_good_core/core/domain/model/failures.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';

part 'login_response.freezed.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required AuthToken accessToken,
    required AuthToken refreshToken,
  }) = _LoginResponse;

  const LoginResponse._();

  Option<Failure> get failureOption => accessToken.failureOrUnit //
      .andThen(refreshToken.failureOrUnit)
      .fold(some, (_) => none());
}
