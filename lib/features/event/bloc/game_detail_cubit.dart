import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou/features/event/bloc/game_detail_state.dart';
import 'package:vou/features/event/domain/entities/game_in_event.dart';
import 'package:vou/features/event/domain/usecases/get_game_detail_usecase.dart';
import 'package:vou/features/event/domain/usecases/get_game_type_usecase.dart';
import 'package:vou/features/event/domain/usecases/get_user_live_usecase.dart';

import '../../../core/logger/sentry_logger_util.dart';
import '../domain/entities/game_type_model.dart';

class GameDetailCubit extends Cubit<GameDetailState> {
  GameDetailCubit({
    required GetUserLiveUseCase getUserLiveUseCase,
    required GetGameDetailUseCase getGameDetailUseCase,
    required GetGameTypeUseCase getGameTypeUseCase,
  })  : _getUserLiveUseCase = getUserLiveUseCase,
        _getGameDetailUseCase = getGameDetailUseCase,
        _getGameTypeUseCase = getGameTypeUseCase,
        super(GameDetailInitial());
  final GetUserLiveUseCase _getUserLiveUseCase;
  final GetGameDetailUseCase _getGameDetailUseCase;
  final GetGameTypeUseCase _getGameTypeUseCase;

  Future<void> loadGameDetail({required String gameId, required String eventId}) async {
    emit(GameDetailLoading());

    try {
      GameInEvent game = await _getGameDetailUseCase.call(EventGameParams(gameId: gameId, eventId: eventId));
      int turn = await _getUserLiveUseCase.call(game.eventId);
      GameType gameType = await _getGameTypeUseCase.call(game.gameId);

      emit(GameDetailLoaded(
        game: game,
        turns: turn,
        type: gameType,
      ));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(exception.toString());
      debugPrint(stackTrace.toString());
      emit(GameDetailError(error: exception.toString()));
    }
  }
}
