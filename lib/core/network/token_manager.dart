import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TokenManager {
  String? _accessToken;
  String? _refreshToken;
  String? _userId;
  final Dio _dio;

  TokenManager({required Dio dio}) : _dio = dio;

  Future<String?> getAccessToken() async => _accessToken;

  Future<void> refreshToken() async {
    final response = await _dio.post(
        '${dotenv.env['REFRESH_TOKEN_END_POINT']}',
        data: {
          'userId': _userId,
          'refreshToken': _refreshToken,
        });

    _accessToken = response.data['accessToken'];
  }

  void setTokens(String accessToken, String refreshToken, String userId) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _userId = userId;
  }

  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
    _userId = null;
  }
}
