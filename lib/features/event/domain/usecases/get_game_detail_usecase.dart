import 'package:vou/features/event/domain/entities/game_in_event.dart';
import 'package:vou/features/event/domain/repositories/game_in_event_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetGameDetailUseCase extends UseCase<GameInEvent, EventGameParams> {

  final GameInEventRepository _repository;

  GetGameDetailUseCase({required GameInEventRepository repository}) : _repository = repository;

  @override
  Future<GameInEvent> call(EventGameParams params) async {
    return await _repository.getGameDetailByQuery(gameId: params.eventId, eventId: params.gameId);
  }
}

class EventGameParams {
  final String gameId;
  final String eventId;

  EventGameParams({required this.gameId, required this.eventId});
}