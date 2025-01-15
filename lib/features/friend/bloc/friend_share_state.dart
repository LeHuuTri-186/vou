import 'package:vou/features/friend/domain/entities/friend.dart';

class FriendShareState {}

class FriendShareInitial extends FriendShareState {}

class FriendShareLoading extends FriendShareState {}

class FriendShareLoaded extends FriendShareState {
  final int turns;
  final List<Friend> friends;

  FriendShareLoaded({required this.turns, required this.friends});
}

class FriendShareError extends FriendShareState {
  final String error;

  FriendShareError({required this.error});
}