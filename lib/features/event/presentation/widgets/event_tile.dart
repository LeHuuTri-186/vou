import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vou/core/helpers/datetime_formatter.dart';
import 'package:vou/features/event/domain/entities/event_model.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/box_shadow.dart';

import '../../../../theme/color/colors.dart';
import '../../../../shared/styles/horizontal_spacing.dart';
import '../../../../shared/styles/vertical_spacing.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
    required this.onGetInfoClick,
    required this.onToggleFavorite,
    required this.eventModel,
  });

  final Function() onGetInfoClick;
  final Function() onToggleFavorite;
  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [TBoxShadow.normalBoxShadow],
          color: TColor.doctorWhite,
          borderRadius: TBorderRadius.md,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: TColor.poppySurprise,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    10,
                  ),
                  topRight: Radius.circular(
                    10,
                  ),
                ),
              ),
              child: const Row(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            Padding(
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
          ],
        ),
      ),
    );
  }

  Column _buildDataColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eventModel.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
              ),
        ),
        VSpacing.md,
        AutoSizeText(
          eventModel.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
        VSpacing.sm,
        AutoSizeText(
          '${DateTimeUtil.formatDateTime(eventModel.startDate)} - ${DateTimeUtil.formatDateTime(eventModel.endDate)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: TColor.petRock,
            fontSize: 13,
          ),
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
            child: true
                ? Icon(
                    Icons.star_border_rounded,
                    color: TColor.petRock,
                  )
                : Icon(
                    Icons.star_rounded,
                    color: TColor.goldenState,
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
