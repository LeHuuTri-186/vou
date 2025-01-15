import 'package:vou/features/event/domain/repositories/game_in_event_repository.dart';

import '../../../../core/usecases/usecase.dart';

class LeaveEventUseCase extends UseCase<void, String> {
  final GameInEventRepository _repository;

  LeaveEventUseCase({required GameInEventRepository repository})
      : _repository = repository;

  @override
  Future<void> call(String params) async {
    await _repository.leaveEvent(eventId: params);
  }
}
