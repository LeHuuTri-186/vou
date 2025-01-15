import '../domain/entities/friend.dart';

class FriendState {}

class FriendInitial extends FriendState {}

class FriendLoading extends FriendState {}

class FriendLoaded extends FriendState {
  final List<Friend> friendList;

  FriendLoaded({required this.friendList});
}

class FriendError extends FriendState {
  final String error;

  FriendError({required this.error});
}