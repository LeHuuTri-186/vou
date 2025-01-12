import 'package:dio/dio.dart';
import 'package:vou/features/event/data/datasources/event_api_datasource.dart';
import 'package:vou/features/event/data/models/event_filter_dto.dart';
import 'package:vou/features/event/domain/entities/event_filter_model.dart';
import 'package:vou/features/event/domain/entities/event_model.dart';
import 'package:vou/features/event/domain/repositories/event_repository.dart';

import '../models/event_dto.dart';

class EventRepositoryImpl implements EventRepository {
  final EventApiDatasource _datasource;

  EventRepositoryImpl({required EventApiDatasource datasource}) : _datasource = datasource;

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


    Response response = await _datasource.getEventByFilter(EventFilterDto.fromDomain(filter).toJson());

    if (response.statusCode == 200) {
      final List<dynamic> eventJsonList = response.data;

      final List<EventModel> eventModels = eventJsonList
          .map((eventJson) => EventDto.fromJson(eventJson).toDomain())
          .toList();

      return eventModels;
    } else {
      throw Exception('Failed to fetch events: ${response.statusCode}');
    }
  }
}