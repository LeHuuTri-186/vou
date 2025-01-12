import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/authentication/domain/repositories/auth_repository.dart';

class SignOutUseCase extends UseCase<void, NoParams> {

  final AuthRepository _repository;

  SignOutUseCase({required AuthRepository repository}) : _repository = repository;

  @override
  Future<void> call(NoParams params) async {
    await _repository.logout();
  }
}