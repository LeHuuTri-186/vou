import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/authentication/data/hive_keys.dart';
import 'package:vou/features/event/data/datasources/game_in_event_datasource.dart';
import 'package:vou/features/event/domain/entities/event_model.dart';
import 'package:vou/features/event/domain/entities/game_in_event.dart';
import 'package:vou/features/event/domain/entities/game_type_model.dart';
import 'package:vou/features/event/domain/repositories/game_in_event_repository.dart';

import '../models/event_dto.dart';
import '../models/game_in_event_model.dart';
import '../models/game_type_dto.dart';

class GameInEventRepositoryImpl implements GameInEventRepository {
  final GameInEventDataSource _dataSource;
  final HiveService _hiveService;

  GameInEventRepositoryImpl({required GameInEventDataSource dataSource, required HiveService hiveService})
      : _dataSource = dataSource, _hiveService = hiveService;

  @override
  Future<List<GameInEvent>> getAllGameInEvent({required String eventId}) async {
    Response response = await _dataSource.getAllGameInEvent(eventId: eventId);

    if (response.statusCode == 200) {
      final List<dynamic> eventJsonList = response.data;

      final List<GameInEvent> gamesInEvent = eventJsonList
          .map((gameJson) => GameInEventDto.fromJson(gameJson).toDomain())
          .toList();

      return gamesInEvent;
    } else {
      throw ("Failed to fetch games in event: ${response.statusCode}");
    }
  }

  @override
  Future<GameInEvent> getGameDetail({required String gameId}) async {
    Response response = await _dataSource.getGameDetail(eventGameId: gameId);

    if (response.statusCode == 200) {
      debugPrint(response.data.toString());

      final game = GameInEventDto.fromJson(response.data).toDomain();

      return game;
    } else {
      throw ("Failed to fetch game in event: ${response.statusCode}");
    }
  }

  @override
  Future<EventModel> getEvent({required String eventId}) async {
    Response response = await _dataSource.getEventById(eventId);

    if (response.statusCode == 200) {
      final data = response.data;
      return EventDto(
              name: data["name"],
              endDate: DateTime.parse(data["endDate"] as String),
              id: data["id"],
              description: data["description"],
              image: data["image"],
              startDate: DateTime.parse(data['startDate'] as String),
              turnsPerDay: data["turnsPerDay"],
              hasLiked: true)
          .toDomain();
    } else {
      throw ("Failed to fetch event: ${response.statusCode}");
    }
  }

  @override
  Future<int> getLivesLeft({required String eventId}) async {
    Response response = await _dataSource.getUserLive(eventId: eventId, userId: _hiveService.get(HiveKeys.userId));

    if (response.statusCode == 200) {
      final data = response.data;

      return data["turn"] as int;
    } else {
      throw ("Failed to fetch user turn: ${response.statusCode}");
    }
  }


  @override
  Future<void> joinEvent({required String eventId}) async {
    Map<String, dynamic> data = {
      "eventId": eventId,
      "userId": _hiveService.get(HiveKeys.userId).toString()
    };

    debugPrint(data.toString());
    Response response = await _dataSource.joinEvent(data);

    if (response.statusCode == 201 || response.statusCode == 400) {
      return;
    } else {
      throw Exception('Failed to join event: ${response.statusCode}');
    }
  }

  @override
  Future<void> leaveEvent({required String eventId}) async {
    Map<String, dynamic> data = {
      "eventId": eventId,
      "userId": _hiveService.get(HiveKeys.userId).toString()
    };

    debugPrint(data.toString());
    Response response = await _dataSource.leaveEvent(data);

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to join event: ${response.statusCode}');
    }
  }

  @override
  Future<GameType> getGameType({required String gameId}) async {
    Response response = await _dataSource.getGameType(gameId: gameId);

    if (response.statusCode == 200) {
      return GameTypeDto.fromJson(response.data).toDomain();
    } else {
      throw Exception('Failed to join event: ${response.statusCode}');
    }
  }

  @override
  Future<GameInEvent> getGameDetailByQuery({required String gameId, required String eventId}) async {
    Response response = await _dataSource.getAllGameInEvent(eventId: eventId);

    if (response.statusCode == 200) {
      final List<dynamic> eventJsonList = response.data;

      final List<GameInEvent> gamesInEvent = eventJsonList
          .map((gameJson) => GameInEventDto.fromJson(gameJson).toDomain())
          .toList();

      // Find the game with the specified gameId
      final GameInEvent game = gamesInEvent.firstWhere(
            (game) => game.id == gameId,
        orElse: () => throw ("Game with id $gameId not found in event $eventId."),
      );

      return game;
    } else {
      throw ("Failed to fetch games in event: ${response.statusCode}");
    }
  }
}
