import 'package:vou/features/event/domain/entities/game_in_event.dart';
import 'package:vou/features/event/domain/repositories/game_in_event_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetAllGameInEventUseCase extends UseCase<List<GameInEvent>, String> {

  final GameInEventRepository _repository;

  GetAllGameInEventUseCase({required GameInEventRepository repository}) : _repository = repository;

  @override
  Future<List<GameInEvent>> call(String params) async {
    return await _repository.getAllGameInEvent(eventId: params);
  }
}