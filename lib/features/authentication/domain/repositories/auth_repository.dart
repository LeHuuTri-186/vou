import '../entities/sign_up_data_model.dart';

abstract class AuthRepository {
  Future<void> login({ required String username, required String password});
  Future<void> logout();
  Future<bool> refreshToken();
  Future<String?> getAccessToken();
  Future<void> requestOtp({required String email});
  Future<void> signUp({required SignUpDataModel model});
}