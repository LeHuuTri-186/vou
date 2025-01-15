import '../entities/user_model.dart';

abstract class UserRepository {
  Future<User> getUserDetail();
  Future<void> updateUser({String? firstName, String? lastName, String? email, String? avatar, String? phoneNumber});
}