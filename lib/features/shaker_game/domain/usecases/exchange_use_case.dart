import 'package:vou/features/shaker_game/domain/repositories/puzzle_repository.dart';

import '../../../../core/usecases/usecase.dart';

class ExchangeUseCase extends UseCase<void, String> {
  final PuzzleRepository _repository;

  ExchangeUseCase({required PuzzleRepository repository}) : _repository = repository;
  @override
  Future<void> call(String params) async {
    await _repository.exchange(gameId: params);
  }

}