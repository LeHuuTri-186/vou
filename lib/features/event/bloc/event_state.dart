abstract class EventState {}

class LoadingEvent extends EventState {}

class EventLoaded extends EventState {
  final List<dynamic> eventList;

  EventLoaded({required this.eventList});
}

class LoadingMoreEvent extends EventState {
  final List<dynamic> eventList;

  LoadingMoreEvent({required this.eventList});
}

class EventError extends EventState {
  final String error;

  EventError({required this.error});
}
