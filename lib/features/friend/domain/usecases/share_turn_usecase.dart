import 'package:vou/features/friend/domain/repositories/friend_repository.dart';

import '../../../../core/usecases/usecase.dart';

class ShareTurnUseCase extends UseCase<void, ReceiverParams> {
  final FriendRepository _repository;

  ShareTurnUseCase({required FriendRepository repository})
      : _repository = repository;

  @override
  Future<void> call(ReceiverParams params) async {
    await _repository.shareTurn(userId: params.userId, eventId: params.eventId);
  }
}

class ReceiverParams {
  final String userId;
  final String eventId;

  ReceiverParams({required this.userId, required this.eventId});
}
