import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:very_good_core/core/domain/model/failures.dart';
import 'package:very_good_core/core/domain/model/validators.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  @override
  int get hashCode => value.hashCode;

  Either<Failure, T> get value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  Either<Failure, Unit> get failureOrUnit =>
      value.fold(left, (T r) => right(unit));

  T getOrCrash() =>
      value.fold((Failure failure) => throw Exception(failure.toString()), id);

  bool isValid() => value.isRight();

  @override
  String toString() => 'Value:${value.toString()}';
}

class UniqueId extends ValueObject<String> {
  factory UniqueId() => UniqueId._(right(const Uuid().v1()));
  const UniqueId._(this.value);

  factory UniqueId.fromUniqueString(String uniqueId) =>
      UniqueId._(right(uniqueId));
  @override
  final Either<Failure, String> value;
}

class Url extends ValueObject<String> {
  factory Url(String input) => Url._(
        validateLink(input) // try uri parsing of the input
            .andThen(validateStringEmpty(input, 'URL')), // must not be empty
      );
  const Url._(this.value);
  @override
  final Either<Failure, String> value;
}

class EmailAddress extends ValueObject<String> {
  factory EmailAddress(String input) => EmailAddress._(
        validateStringEmpty(input, 'Email Address') // must not be empty
            .andThen(
          validateEmailAddress(
            input,
          ),
        ), // validate email address using EmailValidator package
      );
  const EmailAddress._(this.value);
  @override
  final Either<Failure, String> value;
}

class Password extends ValueObject<String> {
  factory Password(String input, {bool isHashed = false}) => Password._(
        validateStringEmpty(input, 'Password') // must not be empty
            .andThen(
              validateCharacterLength(
                input,
                6,
                255,
              ),
            ) // password must be at least 6 characters and less than 255
            .andThen(
              encryptPassword(input, isHashed: isHashed),
            ), // encrypt password
      );
  const Password._(this.value);
  @override
  final Either<Failure, String> value;
}

class ValueName extends ValueObject<String> {
  factory ValueName(String input) => ValueName._(
        validateCharacterLength(
          input,
          1,
          255,
        ) // should only be between 1 to 255 characters
            .andThen(
          validateStringEmpty(input, 'Name'),
        ), // should not be empty
      );
  const ValueName._(this.value);

  @override
  final Either<Failure, String> value;
}

class Number extends ValueObject<num> {
  factory Number([num? input]) => Number._(
        validateNegativeNumber(input ?? 0),
      );
  const Number._(this.value); // must only contain positive numbers
  @override
  final Either<Failure, num> value;
}

class AuthToken extends ValueObject<String> {
  factory AuthToken(String input) => AuthToken._(
        validateStringEmpty(input, 'AuthToken'),
      );
  const AuthToken._(this.value); // should not be empty
  @override
  final Either<Failure, String> value;
}

class ContactNumber extends ValueObject<String> {
  factory ContactNumber(String input) => ContactNumber._(
        validateStringEmpty(input, 'ContactNumber') // should not be empty

            .andThen(
          validateCharacterLength(
            input,
            3,
            20,
          ),
        ), // should be between 3 and 20
      );
  const ContactNumber._(this.value);
  @override
  final Either<Failure, String> value;
}

class ValueString extends ValueObject<String> {
  factory ValueString([String? input]) => ValueString._(right(input ?? ''));
  const ValueString._(this.value);
  @override
  final Either<Failure, String> value;
}
