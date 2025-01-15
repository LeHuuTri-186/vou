import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:vou/core/logger/sentry_logger_util.dart';
import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/profile/bloc/user_state.dart';
import 'package:vou/features/profile/domain/usecases/get_user_detail_usecase.dart';
import 'package:vou/features/profile/domain/usecases/params/update_params.dart';
import 'package:vou/features/profile/domain/usecases/update_user_usecase.dart';

import '../domain/entities/user_model.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required GetUserDetailUseCase getUserDetailUseCase, required UpdateUserUseCase updateUserUseCase}) : _getUserDetailUseCase = getUserDetailUseCase, _updateUserUseCase = updateUserUseCase,  super(UserInitial(),);
  final GetUserDetailUseCase _getUserDetailUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  Future<void> getUserDetail() async {
    emit(UserLoading());

    try {
      User user = await _getUserDetailUseCase.call(NoParams());
      emit(UserLoaded(user: user));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(exception.toString());
      emit(UserError(error: exception.toString()));
    }
  }

  Future<void> updateUser({String? firstName, String? lastName, String? phoneNum, String? avatar, String? email}) async {
    emit(UserLoading());
    try {
      await _updateUserUseCase.call(UpdateParams(firstName: firstName, lastName: lastName, phoneNumber: phoneNum,avatar: avatar, email: email,));
      User user = await _getUserDetailUseCase.call(NoParams());
      emit(UserLoaded(user: user));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      debugPrint(exception.toString());
      emit(UserError(error: exception.toString()));
    }
  }
}