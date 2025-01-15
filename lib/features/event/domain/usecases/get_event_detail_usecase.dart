import 'package:vou/features/event/domain/entities/event_model.dart';
import 'package:vou/features/event/domain/repositories/game_in_event_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetEventDetailUseCase extends UseCase<EventModel, String> {

  final GameInEventRepository _repository;

  GetEventDetailUseCase({required GameInEventRepository repository}) : _repository = repository;

  @override
  Future<EventModel> call(String params) async {
    return await _repository.getEvent(eventId: params);
  }

}