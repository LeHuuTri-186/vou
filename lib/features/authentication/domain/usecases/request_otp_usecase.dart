import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/authentication/domain/repositories/auth_repository.dart';

class RequestOtpUseCase extends UseCase<void, String> {

  final AuthRepository _repository;

  RequestOtpUseCase({required AuthRepository repository}) : _repository = repository;

  @override
  Future<void> call(String params) async {
    await _repository.requestOtp(email: params);
  }
}