import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou/core/helpers/notification_helper.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/authentication/data/hive_keys.dart';
import 'package:vou/features/event/data/datasources/event_api_datasource.dart';
import 'package:vou/features/event/data/models/event_filter_dto.dart';
import 'package:vou/features/event/domain/entities/event_filter_model.dart';
import 'package:vou/features/event/domain/entities/event_model.dart';
import 'package:vou/features/event/domain/repositories/event_repository.dart';

import '../models/event_dto.dart';

class EventRepositoryImpl implements EventRepository {
  final EventApiDataSource _datasource;
  final HiveService _service;

  EventRepositoryImpl({required EventApiDataSource datasource, required HiveService hiveService,}) : _datasource = datasource, _service = hiveService;

  @override
  Future<List<EventModel>> getAllEvent() async {
    Response response = await _datasource.getAllEvent();

    if (response.statusCode == 200) {
      final List<dynamic> eventJsonList = response.data;

      // Convert to EventModel list
      final List<EventModel> eventModels = eventJsonList
          .map((eventJson) => EventDto.fromJson(eventJson).toDomain())
          .toList();

      return eventModels;
    } else {
      throw Exception('Failed to fetch events: ${response.statusCode}');
    }
  }

  @override
  Future<List<EventModel>> getEventByFilter(EventFilter filter) async {

    Map<String, dynamic> data = EventFilterDto.fromDomain(filter).toJson();

    data['userId'] = _service.get(HiveKeys.userId).toString();

    Response response = await _datasource.getEventByFilter(data);

    if (response.statusCode == 201) {
      final List<dynamic> eventJsonList = response.data;

      final List<EventModel> eventModels = eventJsonList
          .map((eventJson) => EventDto.fromJson(eventJson).toDomain())
          .toList();

      return eventModels;
    } else {
      throw Exception('Failed to fetch events: ${response.statusCode}');
    }
  }

  @override
  Future<void> likeEventEndPoint({required String eventId}) async {
    Map<String, dynamic> data = {
      "eventId": eventId,
      "userId": _service.get(HiveKeys.userId).toString()
    };

    debugPrint(data.toString());

    Response response = await _datasource.likeEvent(data);

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to like event: ${response.statusCode}');
    }
  }

  @override
  Future<void> unlikeEventEndPoint({required String eventId}) async {
    Map<String, dynamic> data = {
      "eventId": eventId,
      "userId": _service.get(HiveKeys.userId).toString()
    };

    Response response = await _datasource.unlikeEvent(data);

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to unlike event: ${response.statusCode}');
    }
  }
}