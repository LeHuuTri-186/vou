import 'package:dio/dio.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/authentication/data/hive_keys.dart';
import 'package:vou/features/shaker_game/data/datasources/puzzle_api_datasource.dart';
import 'package:vou/features/shaker_game/domain/entities/puzzle_detail_model.dart';
import 'package:vou/features/shaker_game/domain/entities/user_puzzle.dart';
import 'package:vou/features/shaker_game/domain/repositories/puzzle_repository.dart';

import '../models/puzzle_detail_dto.dart';
import '../models/user_puzzle_dto.dart';

class PuzzleRepositoryImpl implements PuzzleRepository {
  final PuzzleApiDataSource _dataSource;
  final HiveService _hiveService;

  PuzzleRepositoryImpl({required PuzzleApiDataSource dataSource, required HiveService hiveService}) : _dataSource = dataSource, _hiveService = hiveService;


  @override
  Future<PuzzleGame> getPuzzleDetail({required String gameId}) async {
    Response response = await _dataSource.getPuzzleDetail(gameId: gameId);

    if (response.statusCode == 200) {
      return PuzzleGameDto.fromJson(response.data).toDomain();
    } else {
      throw("Failed to get Puzzle");
    }
  }

  @override
  Future<void> joinGame({required String gameId}) async {
    final data = {
      "userId": _hiveService.get(HiveKeys.userId),
      "gameOfEventId": gameId,
    };

    Response response = await _dataSource.joinGame(data: data);

    if (response.statusCode == 201) {
      return;
    } else {
      throw("Failed to join puzzle game!");
    }
  }

  @override
  Future<List<UserPuzzle>> getUserPuzzle({required gameId}) async {
    Response response = await _dataSource.getUserPieces(userId: _hiveService.get(HiveKeys.userId), gameId: gameId);

    if (response.statusCode == 200) {
      final List<dynamic> puzzleJsonList = response.data;

      final List<UserPuzzle> userPuzzles = puzzleJsonList
          .map((puzzleJson) => UserPuzzleDto.fromJson(puzzleJson).toDomain())
          .toList();

      return userPuzzles;
    } else {
      throw("Failed to get user puzzle");
    }
  }

  @override
  Future<void> exchange({required String gameId}) async {
    final data = {
      "userId": _hiveService.get(HiveKeys.userId),
      "gameOfEventId": gameId,
    };

    Response response = await _dataSource.exchange(data: data);
  }

  @override
  Future<void> roll({required String gameId}) async {
    final data = {
      "userId": _hiveService.get(HiveKeys.userId),
      "gameOfEventId": gameId,
    };

    Response response = await _dataSource.rollPiece(data: data);
  }
}