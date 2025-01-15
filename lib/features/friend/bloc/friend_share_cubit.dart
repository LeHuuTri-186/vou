import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/event/domain/usecases/get_user_live_usecase.dart';
import 'package:vou/features/friend/bloc/friend_share_state.dart';
import 'package:vou/features/friend/domain/usecases/get_friend_list_usecase.dart';
import 'package:vou/features/friend/domain/usecases/share_turn_usecase.dart';

import '../../../core/logger/sentry_logger_util.dart';
import '../domain/entities/friend.dart';

class FriendShareCubit extends Cubit<FriendShareState> {
  final ShareTurnUseCase _shareTurnUseCase;
  final GetUserLiveUseCase _getUserLiveUseCase;
  final GetFriendListUseCase _getFriendListUseCase;

  FriendShareCubit({required ShareTurnUseCase shareTurnUseCase, required GetUserLiveUseCase getUserLiveUseCase, required GetFriendListUseCase getFriendListUseCase}) : _shareTurnUseCase = shareTurnUseCase, _getUserLiveUseCase = getUserLiveUseCase, _getFriendListUseCase = getFriendListUseCase, super(FriendShareInitial());


  Future<void> loadFriends({required String eventId}) async {
    emit(FriendShareLoading());

    try {
      final friends = await _getFriendListUseCase.call(NoParams());
      final turns = await _getUserLiveUseCase.call(eventId);

      emit(FriendShareLoaded(turns: turns, friends: friends));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(
        exception.toString(),
      );
      emit(
        FriendShareError(
          error: exception.toString(),
        ),
      );
    }
  }

  Future<void> shareTurn({required String eventId, required String userId, required int turnsLeft}) async {
    try {
      if (turnsLeft == 0) {
        return;
      }

      final friends = await _getFriendListUseCase.call(NoParams());
      await _shareTurnUseCase.call(ReceiverParams(userId: userId, eventId: eventId));
      final turns = await _getUserLiveUseCase.call(eventId);

      emit(FriendShareLoaded(turns: turns, friends: friends));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(
        exception.toString(),
      );
      emit(
        FriendShareError(
          error: exception.toString(),
        ),
      );
    }
  }
}
