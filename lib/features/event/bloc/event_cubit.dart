import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou/core/di/service_locator.dart';
import 'package:vou/core/helpers/notification_helper.dart';

import '../../../core/logger/sentry_logger_util.dart';
import '../../../core/storage/hive_service.dart';
import '../domain/entities/event_filter_model.dart';
import '../domain/usecases/get_event_by_filter_usecase.dart';
import '../domain/usecases/like_event_usecase.dart';
import '../domain/usecases/unlike_event_usecase.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final LikeEventUseCase _likeEventUseCase;
  final UnlikeEventUseCase _unlikeEventUseCase;
  final GetEventByFilterUseCase _getEventByFilterUseCase;


  List<dynamic> _eventList = [];
  int _currentPage = 1;
  bool _hasMoreEvents = true;
  bool _isFetching = false;

  EventFilter eventFilter = EventFilter(
    searchName: '',
    userStatusFilter: [],
    statusFilter: [],
    page: 1,
    perPage: 5,
    sorts: [],
  );

  EventCubit({
    required LikeEventUseCase likeEventUseCase,
    required UnlikeEventUseCase unlikeEventUseCase,
    required GetEventByFilterUseCase getEventByFilterUseCase,
  })  : _likeEventUseCase = likeEventUseCase,
        _unlikeEventUseCase = unlikeEventUseCase,
        _getEventByFilterUseCase = getEventByFilterUseCase,

        super(LoadingEvent());

  Future<void> fetchInitialEvents() async {
    _currentPage = 1;
    _hasMoreEvents = true;
    _eventList = [];
    emit(LoadingEvent());
    await _loadMoreEvents();
  }

  Future<void> loadMoreEvents() async {
    if (!_hasMoreEvents || _isFetching) return;
    emit(LoadingMoreEvent(eventList: _eventList));
    await _loadMoreEvents();
  }

  Future<void> _loadMoreEvents() async {
    if (_isFetching) {
      return;
    }
    _isFetching = true;

    try {
      final updatedFilter = eventFilter.copyWith(page: _currentPage);
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

      debugPrint(exception.toString());
    } finally {
      _isFetching = false;
    }
  }

  void updateFilter(EventFilter newFilter) {
    eventFilter = newFilter;
    fetchInitialEvents(); // Automatically fetch events based on the updated filter
  }

  Future<void> likeEvent({required String eventId}) async {
    try {
      // Optimistically update the UI by marking the event as liked
      final index = _eventList.indexWhere((event) => event.id == eventId);
      if (index != -1) {
        final updatedEvent = _eventList[index].copyWith(hasLiked: true);
        _eventList[index] = updatedEvent;
        NotificationHelper.scheduleEventNotifications(event: updatedEvent, hiveService: $serviceLocator<HiveService>());
        emit(EventLoaded(eventList: List.from(_eventList))); // Emit updated list
      }

      // Call the like use case
      await _likeEventUseCase.call(eventId);
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      emit(EventError(error: exception.toString()));
      debugPrint(exception.toString());

      // Revert the UI update if the like action fails
      final index = _eventList.indexWhere((event) => event.id == eventId);
      if (index != -1) {
        NotificationHelper.cancelEventNotifications(eventId: eventId);
        final updatedEvent = _eventList[index].copyWith(hasLiked: false);
        _eventList[index] = updatedEvent;
        emit(EventLoaded(eventList: List.from(_eventList))); // Revert the list
      }
    }
  }

  Future<void> unlikeEvent({required String eventId}) async {
    try {
      // Optimistically update the UI by marking the event as unliked
      final index = _eventList.indexWhere((event) => event.id == eventId);
      if (index != -1) {
        final updatedEvent = _eventList[index].copyWith(hasLiked: false);
        _eventList[index] = updatedEvent;
        NotificationHelper.cancelEventNotifications(eventId: eventId);
        emit(EventLoaded(eventList: List.from(_eventList))); // Emit updated list
      }

      // Call the unlike use case
      await _unlikeEventUseCase.call(eventId);
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      emit(EventError(error: exception.toString()));
      debugPrint(exception.toString());

      // Revert the UI update if the unlike action fails
      final index = _eventList.indexWhere((event) => event.id == eventId);
      if (index != -1) {
        final updatedEvent = _eventList[index].copyWith(hasLiked: true);
        NotificationHelper.scheduleEventNotifications(event: updatedEvent, hiveService: $serviceLocator<HiveService>());
        _eventList[index] = updatedEvent;
        emit(EventLoaded(eventList: List.from(_eventList))); // Revert the list
      }
    }
  }
}

