import '../../../../core/usecases/usecase.dart';
import '../repositories/event_repository.dart';

class LikeEventUseCase extends UseCase<void, String> {
  final EventRepository _repository;

  LikeEventUseCase({required EventRepository repository})
      : _repository = repository;

  @override
  Future<void> call(String params) async {
    await _repository.likeEventEndPoint(eventId: params);
  }
}