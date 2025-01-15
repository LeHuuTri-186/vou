import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/profile/domain/repositories/user_repository.dart';

import '../entities/user_model.dart';

class GetUserDetailUseCase extends UseCase<User, NoParams> {
  final UserRepository _repository;

  GetUserDetailUseCase({required UserRepository userRepository})
      : _repository = userRepository;

  @override
  Future<User> call(NoParams params) async {
    return await _repository.getUserDetail();
  }
}
