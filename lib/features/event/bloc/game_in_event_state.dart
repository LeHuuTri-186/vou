import 'package:vou/features/event/domain/entities/event_model.dart';

import '../domain/entities/game_in_event.dart';

class GameInEventState {}

class GameInEventInitial extends GameInEventState {}

class GameInEventLoading extends GameInEventState {}

class JoinedEvent extends GameInEventState {}

class FailedToJoin extends GameInEventState {}

class LeaveEvent extends GameInEventState {}

class EventLoading extends GameInEventState {}

class EventLoaded extends GameInEventState {
  final EventModel eventModel;

  EventLoaded({required this.eventModel});
}

class GameInEventLoaded extends GameInEventState {
  final EventModel eventModel;
  final List<GameInEvent> gameList;
  final int turns;

  GameInEventLoaded({
    required this.gameList,
    required this.eventModel,
    required this.turns,
  });
}

class GameInEventError extends GameInEventState {
  final String error;

  GameInEventError({required this.error});
}
