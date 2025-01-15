import 'package:vou/features/event/domain/entities/game_in_event.dart';
import 'package:vou/features/event/domain/entities/game_type_model.dart';

class GameDetailState {}

class GameDetailInitial extends GameDetailState {}

class GameDetailLoading extends GameDetailState {}

class GameDetailLoaded extends GameDetailState {
  final GameInEvent game;
  final int turns;
  final GameType type;

  GameDetailLoaded({required this.game, required this.turns, required this.type});
}

class GameDetailError extends GameDetailState {
  final String error;

  GameDetailError({required this.error});
}