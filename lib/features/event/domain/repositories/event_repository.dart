import 'package:vou/features/event/domain/entities/event_model.dart';

abstract class EventRepository {
  Future<List<EventModel>> getAllEvent();
}