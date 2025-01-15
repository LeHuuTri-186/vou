import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PuzzleApiDataSource {
  final Dio _dio;

  PuzzleApiDataSource({required Dio dio}) : _dio = dio;

  Future<Response> getPuzzleDetail({required String gameId}) async {
      Response response = await _dio.get('${dotenv.env["GET_PUZZLE_END_POINT"]}/$gameId');

      return response;
  }

  Future<Response> joinGame({required Map<String, dynamic> data}) async {
    Response response = await _dio.post('${dotenv.env["SHAKER_GAME_JOIN_END_POINT"]}',data: data);

    return response;
  }

  Future<Response> rollPiece({required Map<String, dynamic> data}) async {
    Response response = await _dio.post('${dotenv.env["SHAKER_GAME_ROLL_END_POINT"]}',data: data);

    return response;
  }

  Future<Response> exchange({required Map<String, dynamic> data}) async {
    Response response = await _dio.post('${dotenv.env["SHAKER_GAME_EXCHANGE_END_POINT"]}',data: data);

    return response;
  }

  Future<Response> getUserPieces({required String userId, required String gameId}) async {
    Response response = await _dio.get('${dotenv.env["SHAKER_GAME_GET_PUZZLE_END_POINT"]}/$userId/$gameId');

    return response;
  }

  Future<Response> getRollHistory({required String userId, required String gameId}) async {
    Response response = await _dio.get('${dotenv.env["SHAKER_GAME_ROLL_HISTORY"]}/$userId/$gameId');

    return response;
  }
}