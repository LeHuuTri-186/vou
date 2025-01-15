import '../domain/entities/friend.dart';

class FriendSearchState {}

class FriendSearching extends FriendSearchState {}

class FriendSearchInitial extends FriendSearchState {}

class FriendSearched extends FriendSearchState {
  final Friend friend;

  FriendSearched({required this.friend});
}

class FriendSearchError extends FriendSearchState {
  final String error;

  FriendSearchError({required this.error});
}