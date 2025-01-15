import 'package:vou/features/event/domain/repositories/game_in_event_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetUserLiveUseCase extends UseCase<int, String> {
  final GameInEventRepository _repository;

  GetUserLiveUseCase({required GameInEventRepository repository}) : _repository = repository;

  @override
  Future<int> call(String params) async {
    return await _repository.getLivesLeft(eventId: params);
  }
}