import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:vou/core/logger/sentry_logger_util.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/authentication/domain/entities/sign_up_data_model.dart';
import 'package:vou/features/authentication/domain/usecases/request_otp_usecase.dart';
import 'package:vou/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:vou/features/authentication/domain/usecases/sign_out_usecase.dart';
import 'package:vou/features/authentication/domain/usecases/sign_up_usecase.dart';

import '../data/hive_keys.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      {required SignOutUseCase signOutUseCase,
      required RequestOtpUseCase requestOtpUseCase,
      required SignUpUseCase signUpUseCase,
      required SignInUseCase signInUseCase,
      required HiveService hiveService})
      : _requestOtpUseCase = requestOtpUseCase,
        _signUpUseCase = signUpUseCase,
        _signInUseCase = signInUseCase,
        _hiveService = hiveService,
        _signOutUseCase = signOutUseCase,
        super(AuthInitial());

  final RequestOtpUseCase _requestOtpUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;
  final HiveService _hiveService;

  Future<void> logIn(String username, String password) async {
    try {
      emit(AuthLoading());
      await _signInUseCase
          .call(SignInParams(username: username, password: password));
      emit(Authenticated(username));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      emit(SignInError(error: exception.toString()));
    }
  }

  Future<void> checkAuthentication() async {
    emit(AuthLoading());
    final accessToken = _hiveService.get(HiveKeys.accessToken);

    if (accessToken != null && accessToken.isNotEmpty) {
      emit(Authenticated(''));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    _signOutUseCase.call(NoParams());
    emit(AuthInitial());
  }

  Future<void> requestOtp(String email) async {
    try {
      emit(AuthLoading());
      await _requestOtpUseCase.call(email);
    } catch (exception, stackTrace) {
      debugPrint(exception.toString());
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      emit(RegisteredEmail());
    }
  }

  Future<void> signUp(SignUpDataModel model) async {
    try {
      emit(AuthLoading());
      await _signUpUseCase.call(model);
    } catch (exception, stackTrace) {
      debugPrint(exception.toString());
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      emit(SignUpError(error: exception.toString()));
    }
  }
}
