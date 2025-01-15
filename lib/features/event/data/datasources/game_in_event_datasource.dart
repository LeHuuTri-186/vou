import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GameInEventDataSource {
  final Dio _dio;

  GameInEventDataSource({required Dio dio}) : _dio = dio;

  Future<Response> getAllGameInEvent({required String eventId}) async {
    Response response = await _dio.get('${dotenv.env['GAME_OF_EVENT_QUERY_END_POINT']}?eventId=$eventId' ?? '');

    return response;
  }

  Future<Response> getEventById(String eventId) async {
    Response response = await _dio.get('${dotenv.env['GET_EVENT_END_POINT']}/$eventId');

    return response;
  }

  Future<Response> getUserLive({required String eventId, required String userId}) async {
    Response response = await _dio.get('${dotenv.env['USER_EVENT_END_POINT']}/$eventId/$userId');

    return response;
  }

  Future<Response> joinEvent(Map<String, dynamic> data) async {
    Response response = await _dio.post(dotenv.env['JOIN_EVENT_END_POINT'] ?? '', data: data);

    return response;
  }

  Future<Response> leaveEvent(Map<String, dynamic> data) async {
    Response response = await _dio.post(dotenv.env['LEAVE_EVENT_END_POINT'] ?? '', data: data);

    return response;
  }

  Future<Response> getGameDetail({required String eventGameId}) async {


    Response response = await _dio.get('${dotenv.env['GAME_DETAIL_END_POINT']}/$eventGameId');

    return response;
  }

  Future<Response> getGameType({required String gameId}) async {
    Response response = await _dio.get('${dotenv.env['GAME_TYPE_END_POINT']}/$gameId');

    return response;
  }
}