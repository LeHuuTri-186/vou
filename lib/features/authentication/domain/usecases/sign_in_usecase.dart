import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/authentication/domain/repositories/auth_repository.dart';

class SignInParams {
  final String username;
  final String password;

  SignInParams({required this.username, required this.password});
}

class SignInUseCase extends UseCase<void, SignInParams> {
  final AuthRepository _repository;

  SignInUseCase({required AuthRepository repository}) : _repository = repository;

  @override
  Future<void> call(SignInParams params) async {
    await _repository.login(username: params.username, password: params.password);
  }
}