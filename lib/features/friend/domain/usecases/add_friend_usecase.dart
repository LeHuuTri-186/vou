import 'package:vou/features/friend/domain/repositories/friend_repository.dart';

import '../../../../core/usecases/usecase.dart';

class AddFriendUseCase extends UseCase<void, String> {

  final FriendRepository _repository;

  AddFriendUseCase({required FriendRepository repository}) : _repository = repository;

  @override
  Future<void> call(String params) async {
    await _repository.addFriend(userId: params);
  }
}