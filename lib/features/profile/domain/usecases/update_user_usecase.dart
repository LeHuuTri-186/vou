import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/profile/domain/usecases/params/update_params.dart';

import '../repositories/user_repository.dart';

class UpdateUserUseCase extends UseCase<void, UpdateParams> {
  final UserRepository _repository;

  UpdateUserUseCase({required UserRepository userRepository})
      : _repository = userRepository;

  @override
  Future<void> call(UpdateParams params) async {
    await _repository.updateUser(
      firstName: params.firstName,
      lastName: params.lastName,
      avatar: params.avatar,
      phoneNumber: params.phoneNumber,
      email: params.email,
    );
  }
}
