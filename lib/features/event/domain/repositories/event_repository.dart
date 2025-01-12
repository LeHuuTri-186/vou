import 'package:vou/features/event/domain/entities/event_filter_model.dart';
import 'package:vou/features/event/domain/entities/event_model.dart';

abstract class EventRepository {
  Future<List<EventModel>> getAllEvent();
  Future<List<EventModel>> getEventByFilter(EventFilter filter);
}