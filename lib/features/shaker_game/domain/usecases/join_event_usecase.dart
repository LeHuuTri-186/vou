import 'package:vou/features/shaker_game/domain/repositories/puzzle_repository.dart';

import '../../../../core/usecases/usecase.dart';

class JoinPuzzleGameUseCase extends UseCase<void, String> {
  final PuzzleRepository _repository;

  JoinPuzzleGameUseCase({required PuzzleRepository repository}) : _repository = repository;

  @override
  Future<void> call(String params) async {
    await _repository.joinGame(gameId: params);
  }
}