import 'package:vou/features/event/domain/entities/event_filter_model.dart';
import 'package:vou/features/event/domain/entities/event_model.dart';
import 'package:vou/features/event/domain/repositories/event_repository.dart';

import '../../../../core/usecases/usecase.dart';

class GetEventByFilterUseCase extends UseCase<List<EventModel>, EventFilter>{

  final EventRepository _repository;

  GetEventByFilterUseCase({required EventRepository repository}) : _repository = repository;

  @override
  Future<List<EventModel>> call(EventFilter params) async {
    return await _repository.getEventByFilter(params);
  }
}