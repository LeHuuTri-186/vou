import 'package:vou/core/usecases/usecase.dart';
import 'package:vou/features/friend/domain/repositories/friend_repository.dart';

import '../entities/friend.dart';

class GetFriendListUseCase extends UseCase<List<Friend>, NoParams> {

  final FriendRepository _repository;

  GetFriendListUseCase({required FriendRepository repository}) : _repository = repository;

  @override
  Future<List<Friend>> call(NoParams params) {
    return _repository.getFriendList();
  }
}