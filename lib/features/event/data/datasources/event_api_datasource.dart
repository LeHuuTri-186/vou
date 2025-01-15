import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EventApiDataSource {
  final Dio _dio;

  EventApiDataSource({required Dio dio}) : _dio = dio;

  Future<Response> getAllEvent() async {
    Response response = await _dio.get(dotenv.env['EVENT_END_POINT'] ?? '');

    return response;
  }

  Future<Response> getEventByFilter(Map<String, dynamic> data) async {
    Response response = await _dio.post(dotenv.env['EVENT_QUERY_END_POINT'] ?? '', data: data);

    return response;
  }

  Future<Response> likeEvent(Map<String, dynamic> data) async {
    Response response = await _dio.post(dotenv.env['LIKE_EVENT_END_POINT'] ?? '', data: data);

    return response;
  }

  Future<Response> unlikeEvent(Map<String, dynamic> data) async {
    Response response = await _dio.post(dotenv.env['UNLIKE_EVENT_END_POINT'] ?? '', data: data);

    return response;
  }
}
