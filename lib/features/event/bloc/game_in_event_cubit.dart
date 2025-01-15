import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou/features/event/bloc/game_in_event_state.dart';
import 'package:vou/features/event/domain/entities/event_model.dart';
import 'package:vou/features/event/domain/usecases/get_all_game_in_event_usecase.dart';
import 'package:vou/features/event/domain/usecases/get_event_detail_usecase.dart';
import 'package:vou/features/event/domain/usecases/get_user_live_usecase.dart';

import '../../../core/logger/sentry_logger_util.dart';
import '../domain/entities/game_in_event.dart';
import '../domain/usecases/join_event_usecase.dart';
import '../domain/usecases/leave_event_usecase.dart';

class GameCubit extends Cubit<GameInEventState> {
  GameCubit({
    required GetAllGameInEventUseCase getAllGameInEventUseCase,
    required GetEventDetailUseCase getEventDetailUseCase,
    required GetUserLiveUseCase getUserLiveUseCase,
    required JoinEventUseCase joinEventUseCase,
    required LeaveEventUseCase leaveEventUseCase,
  })  : _allGameInEventUseCase = getAllGameInEventUseCase,
        _getEventDetailUseCase = getEventDetailUseCase,
        _getUserLiveUseCase = getUserLiveUseCase,
        _joinEventUseCase = joinEventUseCase,
        _leaveEventUseCase = leaveEventUseCase,
        super(GameInEventInitial());

  final GetAllGameInEventUseCase _allGameInEventUseCase;
  final GetEventDetailUseCase _getEventDetailUseCase;
  final GetUserLiveUseCase _getUserLiveUseCase;
  final JoinEventUseCase _joinEventUseCase;
  final LeaveEventUseCase _leaveEventUseCase;

  Future<void> getAllGameInEvent({required String eventId}) async {
    emit(GameInEventLoading());

    try {
      try {
        await _joinEventUseCase.call(eventId);
      } catch (exception, stackTrace) {
        LoggerUtil.captureException(exception, stackTrace: stackTrace);
        debugPrint(exception.toString());
        emit(FailedToJoin());
        return;
      }

      EventModel eventModel = await _getEventDetailUseCase.call(eventId);
      int turns = await _getUserLiveUseCase.call(eventId);
      List<GameInEvent> games = await _allGameInEventUseCase.call(eventId);
      emit(
        GameInEventLoaded(
          gameList: games,
          eventModel: eventModel,
          turns: turns,
        ),
      );
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(exception.toString());
      emit(GameInEventError(error: exception.toString()));
    }
  }

  Future<void> leaveEvent({required String eventId}) async {
    try {
      await _leaveEventUseCase.call(eventId);
      emit(LeaveEvent());
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(exception.toString());
      emit(FailedToJoin());
      return;
    }
  }
}
