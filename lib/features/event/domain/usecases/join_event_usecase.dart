
import '../../../../core/usecases/usecase.dart';
import '../repositories/game_in_event_repository.dart';

class JoinEventUseCase extends UseCase<void, String> {
  final GameInEventRepository _repository;

  JoinEventUseCase({required GameInEventRepository repository})
      : _repository = repository;

  @override
  Future<void> call(String params) async {
    await _repository.joinEvent(eventId: params);
  }
}
