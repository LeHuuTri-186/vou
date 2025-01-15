import 'package:vou/features/shaker_game/domain/entities/puzzle_detail_model.dart';
import 'package:vou/features/shaker_game/domain/repositories/puzzle_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetPuzzleDetailUseCase extends UseCase<PuzzleGame, String> {

  final PuzzleRepository _repository;

  GetPuzzleDetailUseCase({required PuzzleRepository repository}) : _repository = repository;

  @override
  Future<PuzzleGame> call(String params) async {
    return await _repository.getPuzzleDetail(gameId: params);
  }
}
