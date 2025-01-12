import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou/core/constants.dart';
import 'package:vou/features/event/bloc/event_cubit.dart';
import 'package:vou/features/event/bloc/event_state.dart';
import 'package:vou/features/event/domain/entities/event_filter_model.dart';
import 'package:vou/features/event/presentation/widgets/category_selector.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';
import 'package:vou/shared/widgets/buttons_pair.dart';
import 'package:vou/shared/widgets/image_icon.dart';

import '../../../../shared/widgets/loading_widget.dart';
import '../../../../theme/color/colors.dart';
import '../../../../shared/widgets/search_bar.dart';
import '../widgets/event_tile.dart';

class EventPage extends StatelessWidget {
  EventPage({super.key});

  late EventFilter eventFilter;

  @override
  Widget build(BuildContext context) {
    eventFilter = EventFilter(searchName: '', userStatusFilter: [], statusFilter: [], page: 1, perPage: 5, sorts: []);
    context.read<EventCubit>().fetchInitialEvents(eventFilter);
    return Scaffold(
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: TColor.doctorWhite,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Filter",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium),
                                            CloseButton(
                                              onPressed:
                                                  Navigator.of(context).pop,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                VSpacing.md,
                                                Text("Event Status",
                                                    style: Theme.of(context)
                                                        .textTheme.bodyLarge),
                                                CategoryChips(categories: $constants.eventFilterOptions.values.toList(), onSelectionChanged: (categories) {},),
                                                VSpacing.md,
                                                Text("Sort",
                                                    style: Theme.of(context)
                                                        .textTheme.bodyLarge),
                                                ButtonsPair(isFirstSelected: true, firstOnTap: () {}, secondOnTap: () {}, firstButtonText: "Ascending", secondButtonText: "Descending", borderRadius: 4,),
                                                VSpacing.md,

                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () => {

                                                      },
                                                      borderRadius: TBorderRadius.md,
                                                      child: Ink(
                                                        decoration: BoxDecoration(
                                                          color: TColor.poppySurprise,
                                                          borderRadius: TBorderRadius.md,
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                                                          child: AutoSizeText(
                                                            "Ok",
                                                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                              color: TColor.doctorWhite,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VSpacing.sm,
            AutoSizeText(
              "An Error occurred!",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: TColor.petRock,
                  ),
            ),
            VSpacing.sm,
            const ImageIconWidget(
              imagePath: 'assets/images/error.png',
              width: 300,
              height: 300,
            ),
            VSpacing.sm,
            AutoSizeText(
              "Please try again!",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: TColor.petRock,
                    fontSize: 16,
                  ),
            ),
            VSpacing.sm,
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.read<EventCubit>().fetchInitialEvents(eventFilter),
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
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: TColor.doctorWhite,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            VSpacing.md,
          ],
        ),
      ),
    );
  }
}
