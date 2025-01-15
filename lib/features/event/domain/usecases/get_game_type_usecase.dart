import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/event/domain/repositories/game_in_event_repository.dart';

import '../entities/game_type_model.dart';

class GetGameTypeUseCase extends UseCase<GameType, String> {

  final GameInEventRepository _repository;

  GetGameTypeUseCase({required GameInEventRepository repository}) : _repository = repository;

  @override
  Future<GameType> call(String params) async {
    return await _repository.getGameType(gameId: params);
  }
}