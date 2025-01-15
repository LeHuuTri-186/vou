import 'package:flutter/material.dart';

import '../../../../shared/styles/border_radius.dart';
import '../../domain/entities/game_in_event.dart';

class GameIcon extends StatelessWidget {
  const GameIcon({
    super.key,
    required this.gameInEvent,
    this.width = 60,
    this.height = 60,
  });

  final GameInEvent gameInEvent;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: TBorderRadius.md,
        image: DecorationImage(
          image: NetworkImage(gameInEvent.image),
        ),
      ),
    );
  }
}