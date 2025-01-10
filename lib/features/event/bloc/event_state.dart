import 'package:vou/features/event/domain/entities/event_model.dart';

abstract class EventState {}

class LoadingEvent extends EventState {}

class EventLoaded extends EventState {
  final List<EventModel> eventList;

  EventLoaded({required this.eventList});
}

class EventError extends EventState {
  final String error;

  EventError({required this.error});
}