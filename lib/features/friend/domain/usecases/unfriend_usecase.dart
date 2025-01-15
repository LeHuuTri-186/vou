import 'package:vou/core/usecases/usecase.dart';

import '../repositories/friend_repository.dart';

class UnfriendUseCase extends UseCase<void, String> {

  final FriendRepository _repository;

  UnfriendUseCase({required FriendRepository repository}) : _repository = repository;

  @override
  Future<void> call(String params) async {
    await _repository.unFriend(userId: params);
  }
}