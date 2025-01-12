import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/authentication/domain/entities/sign_up_data_model.dart';
import 'package:vou/features/authentication/domain/repositories/auth_repository.dart';

class SignUpUseCase extends UseCase<void, SignUpDataModel> {
  final AuthRepository _repository;

  SignUpUseCase({required AuthRepository repository}) : _repository = repository;

  @override
  Future<void> call(SignUpDataModel params) async {
    await _repository.signUp(model: params);
  }
}