import 'package:vou/features/event/domain/entities/game_in_event.dart';

class GameWithType {
  final GameInEvent game;
  final String type;

  GameWithType({
    required this.game,
    required this.type,
  });
}