import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vou/features/event/data/models/event_dto.dart';

class EventApiDatasource {
  late Dio _dio;

  EventApiDatasource({required Dio dio}) : _dio = dio;

  Future<Response> getAllEvent() async {
    Response response = await _dio.get(dotenv.env['EVENT_END_POINT'] ?? '');

    return response;
  }
}
