import '../domain/entities/user_model.dart';

class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded({required this.user});
}

class UserError extends UserState {
  final String error;

  UserError({required this.error});
}