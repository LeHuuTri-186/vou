import '../../../../core/usecases/usecase.dart';
import '../entities/friend.dart';
import '../repositories/friend_repository.dart';

class FindFriendUseCase extends UseCase<Friend, String> {

  final FriendRepository _repository;

  FindFriendUseCase({required FriendRepository repository}) : _repository = repository;

  @override
  Future<Friend> call(String params) async {
    return await _repository.findFriendByPhoneNum(phoneNum: params);
  }
}