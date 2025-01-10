import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/event/domain/entities/event_model.dart';
import 'package:vou/features/event/domain/repositories/event_repository.dart';

class GetAllEventUseCase implements UseCase<List<EventModel>, NoParams> {
  final EventRepository _repository;

  GetAllEventUseCase({
    required EventRepository repository,
  }) : _repository = repository;

  @override
  Future<List<EventModel>> call(NoParams params) async {
    List<EventModel> eventList = await _repository.getAllEvent();

    return eventList;
  }
}
