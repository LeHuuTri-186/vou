import 'package:bloc/bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vou/core/logger/sentry_logger_util.dart';
import 'package:vou/features/event/bloc/event_state.dart';
import 'package:vou/features/event/domain/usecases/get_all_event_usecase.dart';

import '../../../core/usecases/usecase.dart';

class EventCubit extends Cubit<EventState> {
  final GetAllEventUseCase _getAllEventUseCase;

  EventCubit({
    required GetAllEventUseCase getAllEventUseCase,
  })  : _getAllEventUseCase = getAllEventUseCase,
        super(LoadingEvent());

  Future<void> fetchEvents() async {
    emit(
      LoadingEvent(),
    );
    try {
      final events = await _getAllEventUseCase(
        NoParams(),
      );
      emit(
        EventLoaded(
          eventList: events,
        ),
      );
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(
        exception,
        stackTrace: stackTrace,
      );

      emit(
        EventError(
          error: exception.toString(),
        ),
      );
    }
  }
}
