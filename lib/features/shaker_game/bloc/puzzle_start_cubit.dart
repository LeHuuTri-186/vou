import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou/features/event/domain/usecases/get_user_live_usecase.dart';
import 'package:vou/features/shaker_game/bloc/puzzle_start_state.dart';
import 'package:vou/features/shaker_game/domain/usecases/exchange_use_case.dart';
import 'package:vou/features/shaker_game/domain/usecases/get_puzzle_detail_usecase.dart';
import 'package:vou/features/shaker_game/domain/usecases/get_user_puzzles_usecase.dart';
import 'package:vou/features/shaker_game/domain/usecases/join_event_usecase.dart';

import '../../../core/logger/sentry_logger_util.dart';

class PuzzleStartCubit extends Cubit<PuzzleStartState> {
  final GetUserLiveUseCase _getUserLiveUseCase;
  final GetPuzzleDetailUseCase _getPuzzleDetailUseCase;
  final GetUserPuzzleUseCase _getUserPuzzleUseCase;
  final JoinPuzzleGameUseCase _joinPuzzleGameUseCase;
  final ExchangeUseCase _exchangeUseCase;

  PuzzleStartCubit(
      {required GetUserLiveUseCase getUserLiveUseCase,
      required GetPuzzleDetailUseCase getPuzzleDetailUseCase,
      required GetUserPuzzleUseCase getUserPuzzleUseCase,
      required JoinPuzzleGameUseCase joinPuzzleGameUseCase,
      required ExchangeUseCase exchangeUseCase})
      : _getUserLiveUseCase = getUserLiveUseCase,
        _getPuzzleDetailUseCase = getPuzzleDetailUseCase,
        _getUserPuzzleUseCase = getUserPuzzleUseCase,
        _joinPuzzleGameUseCase = joinPuzzleGameUseCase,
        _exchangeUseCase = exchangeUseCase,
        super(PuzzleStartInitial());

  Future<void> loadPuzzle(
      {required String gameId, required String eventId}) async {
    emit(PuzzleStartLoading());

    try {
      final turns = await _getUserLiveUseCase.call(eventId);
      final puzzleGame = await _getPuzzleDetailUseCase.call(gameId);
      final userPuzzles = await _getUserPuzzleUseCase.call(gameId);

      emit(PuzzleStartLoaded(
          puzzleGame: puzzleGame, turns: turns, userPuzzles: userPuzzles));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      emit(PuzzleStartError(error: exception.toString()));
      debugPrint(exception.toString());
    }
  }

  Future<void> joinGame({required String gameId}) async {
    try {
      await _joinPuzzleGameUseCase.call(gameId);
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      emit(PuzzleStartError(error: exception.toString()));
      debugPrint(exception.toString());
    }
  }

  Future<void> exchange({required String gameId, required String eventId}) async {
    try {
      await _exchangeUseCase.call(gameId);
      loadPuzzle(gameId: gameId, eventId: eventId);
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      emit(PuzzleStartError(error: exception.toString()));
      debugPrint(exception.toString());
    }
  }
}
