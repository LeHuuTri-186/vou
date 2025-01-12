import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EventApiDatasource {
  final Dio _dio;

  EventApiDatasource({required Dio dio}) : _dio = dio;

  Future<Response> getAllEvent() async {
    Response response = await _dio.get(dotenv.env['EVENT_END_POINT'] ?? '');

    return response;
  }

  Future<Response> getEventByFilter(Map<String, dynamic> data) async {
    debugPrint(data.toString());
    Response response = await _dio.post(dotenv.env['EVENT_QUERY_END_POINT'] ?? '', data: data);

    debugPrint(response.statusMessage??'Error');

    return response;
  }

}
