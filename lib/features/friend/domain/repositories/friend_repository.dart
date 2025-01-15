import '../entities/friend.dart';

abstract class FriendRepository {
  Future<List<Friend>> getFriendList();
  Future<Friend> findFriendByPhoneNum({required String phoneNum});
  Future<void> addFriend({required String userId});
  Future<void> unFriend({required String userId});

  Future<void> shareTurn({required String userId, required String eventId});
}