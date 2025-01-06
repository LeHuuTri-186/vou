import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vou/features/event/presentation/widgets/calendar.dart';
import 'package:vou/features/event/presentation/widgets/category_chips_selector.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';

import '../../../../shared/styles/appbar.dart';
import '../../../../theme/color/colors.dart';
import '../../../../shared/widgets/search_bar.dart';
import '../widgets/event_tile.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar.buildAppBar(context: context, title: 'Event'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 5,
                    child: CustomSearchBar(
                      onChanged: (value) {},
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(8),
                          splashColor: TColor.petRock.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Ink(
                              child: Icon(
                                Icons.filter_alt_outlined,
                                color: TColor.petRock,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              VSpacing.sm,
              CollapsibleCategoryChips(
                  categories: const ['All', 'Upcoming', 'Over', 'Now'],
                  onCategorySelected: (c) {}),
              VSpacing.sm,
              VSpacing.sm,
              Expanded(
                child: ListView.builder(
                  itemCount: 10, // Replace with the actual number of items
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(4.0),
                    child: EventTile(
                      index: index,
                      onTap: () {},
                      onGetInfoClick: () {},
                      onToggleFavorite: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
