import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/event/domain/repositories/event_repository.dart';

class UnlikeEventUseCase extends UseCase<void, String> {
  final EventRepository _repository;

  UnlikeEventUseCase({required EventRepository repository})
      : _repository = repository;

  @override
  Future<void> call(String params) async {
    await _repository.unlikeEventEndPoint(eventId: params);
  }
}
