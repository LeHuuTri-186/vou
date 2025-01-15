import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou/core/logger/sentry_logger_util.dart';
import 'package:vou/features/friend/bloc/friend_state.dart';
import 'package:vou/features/friend/domain/usecases/get_friend_list_usecase.dart';

import '../../../core/usecases/usecase.dart';
import '../domain/entities/friend.dart';
import '../domain/usecases/unfriend_usecase.dart';

class FriendCubit extends Cubit<FriendState> {
  FriendCubit(
      {required GetFriendListUseCase getFriendListUseCase,
      required UnfriendUseCase unfriendUseCase})
      : _unfriendUseCase = unfriendUseCase,
        _getFriendListUseCase = getFriendListUseCase,
        super(FriendInitial());

  final GetFriendListUseCase _getFriendListUseCase;
  final UnfriendUseCase _unfriendUseCase;

  Future<void> fetchFriends() async {
    emit(FriendLoading());
    try {
      List<Friend> list = await _getFriendListUseCase.call(NoParams());
      emit(FriendLoaded(friendList: list));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(exception.toString());
      emit(FriendError(error: exception.toString()));
    }
  }

  Future<void> unfriend({required String userId}) async {
    emit(FriendLoading());
    try {
      await _unfriendUseCase.call(userId);
      List<Friend> list = await _getFriendListUseCase.call(NoParams());
      emit(FriendLoaded(friendList: list));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(exception.toString());
      emit(FriendError(error: exception.toString()));
    }
  }
}
