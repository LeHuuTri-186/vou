import 'package:vou/features/shaker_game/domain/entities/user_puzzle.dart';

import '../entities/puzzle_detail_model.dart';

abstract class PuzzleRepository {
  Future<PuzzleGame> getPuzzleDetail({required String gameId});
  Future<void> joinGame({required String gameId});
  Future<List<UserPuzzle>> getUserPuzzle({required gameId});
  Future<void> exchange({required String gameId});
  Future<void> roll({required String gameId});
}