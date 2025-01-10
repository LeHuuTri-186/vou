import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou/core/logger/sentry_logger_util.dart';
import 'package:vou/features/event/bloc/event_cubit.dart';
import 'package:vou/features/event/bloc/event_state.dart';
import 'package:vou/features/event/presentation/widgets/calendar.dart';
import 'package:vou/features/event/presentation/widgets/category_chips_selector.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';

import '../../../../shared/styles/appbar.dart';
import '../../../../shared/styles/box_shadow.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../theme/color/colors.dart';
import '../../../../shared/widgets/search_bar.dart';
import '../widgets/event_tile.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EventCubit>().fetchEvents();
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
              Expanded(
                child: BlocBuilder<EventCubit, EventState>(
                  builder: (context, state) {
                    if (state is EventError) {
                      return _buildErrorPanel(context);
                    }

                    if (state is EventLoaded) {
                      return ListView.builder(
                        itemCount: state.eventList
                            .length, // Replace with the actual number of items
                        itemBuilder: (context, index) => EventTile(
                            onGetInfoClick: () {},
                            onToggleFavorite: () {},
                            eventModel: state.eventList[index]),
                      );
                    }

                    return SafeArea(
                      child: Center(
                        child: LoadingWidget.twistingDotsLoadIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SafeArea _buildErrorPanel(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: TColor.doctorWhite,
            boxShadow: [TBoxShadow.normalBoxShadow],
            borderRadius: TBorderRadius.md,
          ),
          child: Column(
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: TColor.poppySurprise,
                    borderRadius: TBorderRadius.md,
                  ),
                  child: Center(
                    child: AutoSizeText(
                      "An Error occurred!",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: TColor.doctorWhite,
                          ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "Please try again",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: TColor.petRock,
                            ),
                      ),
                      VSpacing.md,
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async =>
                              await context.read<EventCubit>().fetchEvents(),
                          borderRadius: TBorderRadius.md,
                          child: Ink(
                            decoration: BoxDecoration(
                              color: TColor.poppySurprise,
                              borderRadius: TBorderRadius.md,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AutoSizeText(
                                "Try again",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: TColor.doctorWhite,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
