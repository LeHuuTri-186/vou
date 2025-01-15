import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FriendApiDatasource {
  final Dio _dio;

  FriendApiDatasource({
    required Dio dio,
  }) : _dio = dio;

  Future<Response> getUserByPhoneNum(Map<String, dynamic> data) async {
    Response response = await _dio.post(dotenv.env['USER_SEARCH_END_POINT'] ?? '', data:  data);

    return response;
  }

  Future<Response> getUserFriendList() async {
    Response response = await _dio.get(dotenv.env['USER_FRIEND_LIST_END_POINT'] ?? '');

    return response;
  }

  Future<Response> addFriend(Map<String, dynamic> data) async {
    Response response = await _dio.post(dotenv.env['ADD_FRIEND_END_POINT'] ?? '', data: data);
    debugPrint(response.statusCode.toString());
    return response;
  }

  Future<Response> unFriend(Map<String, dynamic> data) async {
    Response response = await _dio.delete(dotenv.env['UNFRIEND_END_POINT'] ?? '', data: data);
    debugPrint("Debug: ${response.statusCode.toString()}");
    return response;
  }

  Future<Response> shareTurn(Map<String, dynamic> data) async {
    Response response = await _dio.post(dotenv.env['FRIEND_GIVE_TURN_END_POINT'] ?? '', data: data);
    debugPrint("Debug: ${response.statusCode.toString()}");
    return response;
  }
}