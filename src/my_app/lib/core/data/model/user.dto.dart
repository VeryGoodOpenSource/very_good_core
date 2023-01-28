import 'dart:convert';
import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:very_good_core/app/constants/enum.dart';
import 'package:very_good_core/app/utils/converters.dart';
import 'package:very_good_core/core/domain/model/user.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';

part 'user.dto.freezed.dart';
part 'user.dto.g.dart';

@freezed
class UserDTO with _$UserDTO {
  const factory UserDTO({
    @JsonKey(name: 'id') required int uid,
    required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    String? avatar,
    String? gender,
    String? contactNumber,
    @StringToDateTime() DateTime? birthday,
  }) = _UserDTO;

  const UserDTO._();

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  factory UserDTO.fromDomain(User user) => UserDTO(
        uid: int.parse(user.uid.getOrCrash()),
        email: user.email.getOrCrash(),
        firstName: user.firstName.getOrCrash(),
        lastName: user.lastName.getOrCrash(),
        avatar: user.avatar?.getOrCrash(),
        gender: user.gender.name,
        contactNumber: user.contactNumber?.getOrCrash(),
        birthday: user.birthday,
      );
  static UserDTO userDTOFromJson(String str) =>
      UserDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  static String userDTOToJson(UserDTO data) => json.encode(data.toJson());

  User toDomain() {
    final Faker faker = Faker();
    final int currentYear = DateTime.now().year;
    const int minYear = 100;
    const int maxYear = 18;

    return User(
      uid: UniqueId.fromUniqueString(uid.toString()),
      firstName: ValueName(firstName),
      lastName: ValueName(lastName),
      email: EmailAddress(email),
      gender: Gender.values.firstWhere(
        (Gender element) => element.name == gender?.toLowerCase(),
        orElse: () => Gender.values[Random().nextInt(Gender.values.length)],
      ),
      birthday: birthday ??
          faker.date.dateTime(
            minYear: currentYear - minYear,
            maxYear: currentYear - maxYear,
          ),
      contactNumber: contactNumber.isNotNullOrBlank
          ? ContactNumber(contactNumber!)
          : ContactNumber(faker.phoneNumber.us()),
      avatar: (avatar?.isNotNullOrBlank ?? false) ? Url(avatar!) : null,
    );
  }
}
