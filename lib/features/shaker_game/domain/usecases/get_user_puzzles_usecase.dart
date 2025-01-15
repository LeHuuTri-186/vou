import 'package:vou/features/shaker_game/domain/entities/user_puzzle.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/puzzle_repository.dart';

class GetUserPuzzleUseCase extends UseCase<List<UserPuzzle>, String> {

  final PuzzleRepository _repository;

  GetUserPuzzleUseCase({required PuzzleRepository repository}) : _repository = repository;

  @override
  Future<List<UserPuzzle>> call(String params) async {
    return await _repository.getUserPuzzle(gameId: params);
  }
}