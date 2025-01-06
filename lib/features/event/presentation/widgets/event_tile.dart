import 'package:flutter/material.dart';

import '../../../../theme/color/colors.dart';
import '../../../../shared/styles/horizontal_spacing.dart';
import '../../../../shared/styles/vertical_spacing.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
    required this.index,
    required this.onTap,
    required this.onGetInfoClick,
    required this.onToggleFavorite,
  });

  final int index;
  final Function() onTap;
  final Function() onGetInfoClick;
  final Function() onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onHover: (_) {},
        borderRadius: BorderRadius.circular(10),
        hoverColor: TColor.grahamHair,
        child: Ink(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: _buildDataColumn(context),
                ),
                Flexible(
                  flex: 1,
                  child: _buildActionRow(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildDataColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Event",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 14,
          ),
        ),
        VSpacing.md,
        Text(
          "Event description",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
      ],
    );
  }

  Row _buildActionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onToggleFavorite,
          borderRadius: BorderRadius.circular(5.0),
          hoverColor: TColor.northEastSnow,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: true ? Icon(
              Icons.star_border_rounded, color: TColor.petRock,
            ) : Icon(
              Icons.star_rounded, color:  TColor.goldenState,
            ),
          ),
        ),
        HSpacing.sm,
        InkWell(
          onTap: onGetInfoClick,
          borderRadius: BorderRadius.circular(5.0),
          hoverColor: TColor.northEastSnow,
          child: const Padding(
            padding: EdgeInsets.all(3.0),
            child: Icon(Icons.info_outline_rounded),
          ),
        ),
      ],
    );
  }
}
