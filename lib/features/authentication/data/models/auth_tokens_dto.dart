import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vou/features/authentication/domain/entities/auth_token_model.dart';

part 'auth_tokens_dto.freezed.dart';
part 'auth_tokens_dto.g.dart';

@freezed
class AuthTokensDto with _$AuthTokensDto {
  const factory AuthTokensDto({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokensDto;

  factory AuthTokensDto.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensDtoFromJson(json);

  // Convert DTO to Model
  AuthTokens toDomain() {
    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  // Convert Model to DTO
  static AuthTokensDto fromDomain(AuthTokensDto model) {
    return AuthTokensDto(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
    );
  }
}
