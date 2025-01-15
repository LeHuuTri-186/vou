import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vou/features/authentication/data/models/sign_up_data_dto.dart';

class AuthApiDataSource {
  final Dio _dio;

  AuthApiDataSource({
    required Dio dio,
  }) : _dio = dio;

  Future<Response> login(String email, String password) async {
    final response = await _dio.post(dotenv.env['SIGN_IN_END_POINT'] ?? '',
        data: {'username': email, 'password': password});
    return response;
  }

  Future<Response> signUp(SignUpDataDto data) async {
    debugPrint(data.toJson().toString());
    final response = await _dio.post(dotenv.env['SIGN_UP_END_POINT'] ?? '',
        data: data.toJson());
    debugPrint(response.data.toString());

    return response;
  }

  Future<Response> getOtp(String email) async {
    final response = await _dio.post(
      dotenv.env['REQUEST_OTP_END_POINT'] ?? '',
      data: {
        'email': email,
      },
    );
    return response;
  }
}
