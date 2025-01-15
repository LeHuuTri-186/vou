import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/logger/sentry_logger_util.dart';
import '../../event/domain/usecases/get_user_live_usecase.dart';
import '../domain/usecases/shake_puzzle_usecase.dart';
part 'shaker_state.dart';

class ShakerCubit extends Cubit<ShakerState> {
  final GetUserLiveUseCase _getUserLiveUseCase;
  final ShakePuzzleUseCase _shakePuzzleUseCase;

  ShakerCubit({
    required GetUserLiveUseCase getUserLiveUseCase,
    required ShakePuzzleUseCase shakePuzzleUseCase,
  })  : _getUserLiveUseCase = getUserLiveUseCase,
        _shakePuzzleUseCase = shakePuzzleUseCase,
        super(
        const ShakerState(
          score: 0,
          shakeChance: 0,
          stateShake: 'phone_shaking',
          isProcessingShake: false,
        ),
      );

  Future<void> loadShakeChance({required String eventId}) async {
    try {
      final int shakeChance = await _getUserLiveUseCase.call(eventId);
      emit(
        ShakerState(
          score: 0,
          shakeChance: shakeChance,
          stateShake: 'phone_shaking',
          isProcessingShake: false,
        ),
      );
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(exception.toString());
    }
  }

  Future<void> onShake({required String id, required String eventId}) async {
    if (state.shakeChance <= 0 || state.isProcessingShake) {
      _handleOutOfTurn();
      return;
    }

    emit(state.copyWith(
      isProcessingShake: true,
      score: state.score + 1,
    ));

    if (state.score + 1 == 5) {
      emit(state.copyWith(stateShake: 'phone_puzzle_pop'));

      await _shakePuzzleUseCase.call(id);

      Future.delayed(const Duration(seconds: 1), () {
        loadShakeChance(eventId: eventId);
      });
    } else {
      emit(
        state.copyWith(isProcessingShake: false),
      );
    }
  }

  void _handleOutOfTurn() {
    // Logic for handling out-of-turn actions, e.g., showing an error message or resetting animation.
    emit(state.copyWith(stateShake: 'out_of_turn'));
    Future.delayed(const Duration(seconds: 1), () {
      emit(state.copyWith(stateShake: 'phone_shaking'));
    });
  }
}
