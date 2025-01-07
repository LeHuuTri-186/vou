import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void navigateToSignUp() {
    emit(NavigateToSignUp());
  }

  void login(String token) {
    emit(Authenticated(token));
  }

  void logout() {
    emit(Unauthenticated());
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    if (json['authenticated'] == true) {
      return Authenticated(json['token']);
    }
    return Unauthenticated();
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is Authenticated) {
      return {'authenticated': true, 'token': state.token};
    }
    return {'authenticated': false};
  }
}
