import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token_model.freezed.dart';

@freezed
class AuthTokens with _$AuthTokens {
  const factory AuthTokens({required String accessToken, required String refreshToken}) = _AuthTokens;
}
