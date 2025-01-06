import 'package:bloc/bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void logIn(String userId) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2)); // Simulate delay
    emit(Authenticated(userId));
  }

  void logOut() {
    emit(Unauthenticated());
  }

  void navigateToSignUp() {
    emit(NavigateToSignUp());
  }
}
