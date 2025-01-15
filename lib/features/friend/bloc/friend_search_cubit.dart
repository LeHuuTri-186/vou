import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou/core/logger/sentry_logger_util.dart';
import 'package:vou/features/friend/domain/usecases/find_friend_usecase.dart';

import '../domain/entities/friend.dart';
import '../domain/usecases/add_friend_usecase.dart';
import 'friend_search_state.dart';

class FriendSearchCubit extends Cubit<FriendSearchState> {
  FriendSearchCubit(
      {required AddFriendUseCase addFriendUseCase,
        required FindFriendUseCase findFriendUseCase})
      : _findFriendUseCase = findFriendUseCase,
        _addFriendUseCase = addFriendUseCase,
        super(FriendSearchInitial());

  final AddFriendUseCase _addFriendUseCase;
  final FindFriendUseCase _findFriendUseCase;

  Future<void> searchFriend({required String phoneNum}) async {
    emit(FriendSearching());

    try {
      Friend friend = await _findFriendUseCase.call(phoneNum);
      emit(FriendSearched(friend: friend));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(
        exception.toString(),
      );
      emit(
        FriendSearchError(
          error: exception.toString(),
        ),
      );
    }
  }

  Future<void> addFriend({required String userId}) async {
    try {
      await _addFriendUseCase.call(userId);
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(
        exception.toString(),
      );
      emit(
        FriendSearchError(
          error: exception.toString(),
        ),
      );
    }
  }
}
