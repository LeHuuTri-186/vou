import 'package:vou/features/event/domain/entities/event_filter_model.dart';
import 'package:vou/features/event/domain/entities/event_model.dart';

abstract class EventRepository {
  Future<List<EventModel>> getAllEvent();
  Future<List<EventModel>> getEventByFilter(EventFilter filter);
  Future<void> likeEventEndPoint({required String eventId});
  Future<void> unlikeEventEndPoint({required String eventId});

}