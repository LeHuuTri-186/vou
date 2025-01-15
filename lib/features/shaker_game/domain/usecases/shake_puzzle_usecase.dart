import '../../../../core/usecases/usecase.dart';
import '../repositories/puzzle_repository.dart';

class ShakePuzzleUseCase extends UseCase<void, String> {
  final PuzzleRepository _repository;

  ShakePuzzleUseCase({required PuzzleRepository repository}) : _repository = repository;
  @override
  Future<void> call(String params) async {
    await _repository.roll(gameId: params);
  }
}