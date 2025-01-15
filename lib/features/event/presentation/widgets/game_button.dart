import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vou/features/event/domain/entities/game_in_event.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/widgets/image_icon.dart';
import '../../../../shared/styles/horizontal_spacing.dart';
import 'game_icon.dart';

class GameButton extends StatelessWidget {
  const GameButton({super.key, required this.gameInEvent, this.onTap});
  final GameInEvent gameInEvent;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: TBorderRadius.md,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: GameIcon(gameInEvent: gameInEvent),
            ),
            HSpacing.sm,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  gameInEvent.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 18),
                ),
                Row(
                  children: [
                    const ImageIconWidget(imagePath: "assets/images/event.png"),
                    HSpacing.sm,
                    AutoSizeText(
                      gameInEvent.description,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
