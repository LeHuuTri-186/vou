import 'package:bloc/bloc.dart';

import '../../../core/logger/sentry_logger_util.dart';
import '../domain/entities/event_filter_model.dart';
import '../domain/usecases/get_all_event_usecase.dart';
import '../domain/usecases/get_event_by_filter_usecase.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final GetAllEventUseCase _getAllEventUseCase;
  final GetEventByFilterUseCase _getEventByFilterUseCase;

  // Internal tracking for pagination
  List<dynamic> _eventList = [];
  int _currentPage = 1;
  bool _hasMoreEvents = true;

  EventCubit({
    required GetAllEventUseCase getAllEventUseCase,
    required GetEventByFilterUseCase getEventByFilterUseCase,
  })  : _getAllEventUseCase = getAllEventUseCase,
        _getEventByFilterUseCase = getEventByFilterUseCase,
        super(LoadingEvent());

  Future<void> fetchInitialEvents(EventFilter initialFilter) async {
    _currentPage = 1;
    _hasMoreEvents = true;
    _eventList = [];
    emit(LoadingEvent());
    await _loadMoreEvents(initialFilter);
  }

  Future<void> loadMoreEvents(EventFilter baseFilter) async {
    if (_hasMoreEvents && state is! LoadingEvent) {
      emit(LoadingMoreEvent(eventList: _eventList));
      await _loadMoreEvents(baseFilter);
    }
  }

  Future<void> _loadMoreEvents(EventFilter baseFilter) async {
    try {
      // Update filter with current page
      final updatedFilter = baseFilter.copyWith(page: _currentPage);
      final events = await _getEventByFilterUseCase.call(updatedFilter);

      if (events.isEmpty) {
        _hasMoreEvents = false;
      } else {
        _currentPage++;
        _eventList.addAll(events);
      }

      emit(EventLoaded(eventList: _eventList));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      emit(EventError(error: exception.toString()));
    }
  }
}
