import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:very_good_core/core/domain/model/value_objects.dart';
import 'package:very_good_core/features/auth/domain/model/login_response.dart';

part 'login_response.dto.freezed.dart';
part 'login_response.dto.g.dart';

@freezed
class LoginResponseDTO with _$LoginResponseDTO {
  const factory LoginResponseDTO({
    @JsonKey(name: 'token') required String accessToken,
    String? refreshToken,
  }) = _LoginResponseDTO;

  const LoginResponseDTO._();

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);

  factory LoginResponseDTO.fromDomain(LoginResponse loginResponse) =>
      LoginResponseDTO(
        accessToken: loginResponse.accessToken.getOrCrash(),
        refreshToken: loginResponse.refreshToken.getOrCrash(),
      );

  static LoginResponseDTO loginDTOFromJson(String str) =>
      LoginResponseDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  static String loginDTOToJson(LoginResponseDTO data) =>
      json.encode(data.toJson());

  LoginResponse toDomain() => LoginResponse(
        accessToken: AuthToken(accessToken),
        refreshToken: AuthToken(refreshToken ?? accessToken),
      );
}
