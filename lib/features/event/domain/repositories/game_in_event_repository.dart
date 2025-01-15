import 'package:vou/features/event/domain/entities/event_model.dart';
import 'package:vou/features/event/domain/entities/game_in_event.dart';

import '../entities/game_type_model.dart';

abstract class GameInEventRepository {
  Future<List<GameInEvent>> getAllGameInEvent({required String eventId});

  Future<GameInEvent> getGameDetail({required String gameId});

  Future<EventModel> getEvent({required String eventId});

  Future<int> getLivesLeft({required String eventId});

  Future<void> joinEvent({required String eventId});
  Future<void> leaveEvent({required String eventId});

  Future<GameType> getGameType({required String gameId});

  Future<GameInEvent> getGameDetailByQuery({required String gameId, required String eventId});
}