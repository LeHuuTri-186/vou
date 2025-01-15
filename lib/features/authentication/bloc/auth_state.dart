import 'package:vou/features/authentication/domain/entities/sign_up_data_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String token;

  Authenticated(this.token);
}

class Unauthenticated extends AuthState {}

class SigningUp extends AuthState {
  final SignUpDataModel model;

  SigningUp({required this.model});
}

class RequestingOtp extends AuthState {
}

class RegisteredSuccessfully extends AuthState {
}

class SignUpError extends AuthState {
  final String error;

  SignUpError({required this.error});
}

class RegisteredEmail extends AuthState {
}

class SignInError extends AuthState {
final String error;

  SignInError({required this.error});
}
