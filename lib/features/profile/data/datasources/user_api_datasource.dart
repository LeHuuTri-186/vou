import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserApiDataSource {
  final Dio _dio;

  UserApiDataSource({required Dio dio}) : _dio = dio;

  Future<Response> getUserDetail() async {
    Response response = await _dio.get(dotenv.env['PROFILE_END_POINT'] ?? '');

    return response;
  }

  Future<Response> updateUser(Map<String, dynamic> data) async {
    Response response = await _dio.post(dotenv.env['UPDATE_USER_END_POINT'] ?? '', data: data);

    return response;
  }
}