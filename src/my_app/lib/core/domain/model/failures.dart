import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:very_good_core/app/constants/enum.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.emptyString({required String? property}) = EmptyString;

  const factory Failure.exceedingCharacterLength({int? min, int? max}) =
      ExceedingCharacterLength;

  const factory Failure.exceedingListLength({
    required List<dynamic> failedValue,
    required int max,
  }) = ExceedingListLength;

  const factory Failure.invalidEmailFormat() = InvalidEmailFormat;

  const factory Failure.invalidValue({required dynamic failedValue}) =
      InvalidValue;

  const factory Failure.invalidUrl({required String failedValue}) = InvalidUrl;

  const factory Failure.unexpected(String? error) = UnexpectedError;

  const factory Failure.serverError(StatusCode code, String? error) =
      ServerError;

  const factory Failure.storageError() = StorageError;
}
