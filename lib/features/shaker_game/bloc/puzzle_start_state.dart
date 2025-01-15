import 'package:vou/features/shaker_game/domain/entities/puzzle_detail_model.dart';
import 'package:vou/features/shaker_game/domain/entities/user_puzzle.dart';

class PuzzleStartState {}

class PuzzleStartInitial extends PuzzleStartState {}

class PuzzleStartLoading extends PuzzleStartState {}

class PuzzleStartLoaded extends PuzzleStartState {
  final PuzzleGame puzzleGame;
  final int turns;
  final List<UserPuzzle> userPuzzles;

  PuzzleStartLoaded({required this.puzzleGame, required this.turns, required this.userPuzzles});
}

class PuzzleStartError extends PuzzleStartState {
  final String error;

  PuzzleStartError({required this.error});
}
