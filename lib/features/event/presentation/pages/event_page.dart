import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/core/constants.dart';
import 'package:vou/features/event/bloc/event_cubit.dart';
import 'package:vou/features/event/bloc/event_state.dart';
import 'package:vou/features/event/domain/entities/event_filter_model.dart';
import 'package:vou/features/event/presentation/widgets/category_selector.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';
import 'package:vou/shared/widgets/image_icon.dart';

import '../../../../shared/widgets/loading_widget.dart';
import '../../../../theme/color/colors.dart';
import '../../../../shared/widgets/search_bar.dart';
import '../widgets/event_tile.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<EventCubit>().fetchInitialEvents();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_scrollController.position.outOfRange) {
      final eventCubit = context.read<EventCubit>();
      eventCubit.loadMoreEvents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 5,
                      child: CustomSearchBar(
                        onChanged: (value) {
                          final updatedFilter = context
                              .read<EventCubit>()
                              .eventFilter
                              .copyWith(searchName: value);
                          context
                              .read<EventCubit>()
                              .updateFilter(updatedFilter);
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              _buildFilterDialog(context);
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
              ),
              VSpacing.sm,
              Expanded(
                child: BlocBuilder<EventCubit, EventState>(
                  builder: (context, state) {
                    if (state is EventError) {
                      return _buildErrorPanel(context);
                    }

                    if (state is EventLoaded || state is LoadingMoreEvent) {
                      final eventList = state is EventLoaded
                          ? state.eventList
                          : (state as LoadingMoreEvent).eventList;
                      final isLoadingMore = state is LoadingMoreEvent;

                      if (eventList.isEmpty) {
                        return _buildEmptyPanel(context);
                      }

                      return ListView.builder(
                        controller:
                            _scrollController, // Attach the ScrollController
                        itemCount: isLoadingMore
                            ? eventList.length + 1
                            : eventList.length,
                        itemBuilder: (context, index) {
                          if (index < eventList.length) {
                            return EventTile(
                              onGetInfoClick: () {},
                              onToggleFavorite: () {
                                _toggleEventLike(eventList, index, context);
                              },
                              eventModel: eventList[index],
                            );
                          } else {
                            // Display loading indicator for the "loading more" state
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child:
                                    LoadingWidget.twistingDotsLoadIndicator(),
                              ),
                            );
                          }
                        },
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

  Future<void> _toggleEventLike(
      List<dynamic> eventList, int index, BuildContext context) {
    return eventList[index].hasLiked
        ? context.read<EventCubit>().unlikeEvent(eventId: eventList[index].id)
        : context.read<EventCubit>().likeEvent(eventId: eventList[index].id);
  }

  Future<dynamic> _buildFilterDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (c) {
        return Dialog(
          backgroundColor: TColor.doctorWhite,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Filter",
                        style: Theme.of(context).textTheme.titleMedium),
                    CloseButton(
                      onPressed: Navigator.of(c).pop,
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VSpacing.md,
                        Text("Event Status",
                            style: Theme.of(context).textTheme.bodyLarge),
                        CategoryChips(
                          selectedValues: context
                              .read<EventCubit>()
                              .eventFilter
                              .userStatusFilter,
                          categories: $constants.eventFilterOptions,
                          onSelectionChanged: (categories) async {
                            final updatedFilter =
                                _updateEventFilterCategory(categories, context);
                            context
                                .read<EventCubit>()
                                .updateFilter(updatedFilter);
                          },
                        ),
                        VSpacing.md,
                        Align(
                          alignment: Alignment.centerRight,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                c.pop();
                              },
                              borderRadius: TBorderRadius.md,
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: TColor.poppySurprise,
                                  borderRadius: TBorderRadius.md,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 4.0),
                                  child: AutoSizeText(
                                    "Ok",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
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
  }

  EventFilter _updateEventFilterCategory(
      List<String> categories, BuildContext context) {
    return categories.contains("ALL")
        ? context.read<EventCubit>().eventFilter.copyWith(userStatusFilter: [])
        : context
            .read<EventCubit>()
            .eventFilter
            .copyWith(userStatusFilter: categories);
  }

  SafeArea _buildEmptyPanel(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VSpacing.sm,
            AutoSizeText(
              "No event found!",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: TColor.petRock,
                  ),
            ),
            VSpacing.sm,
            const ImageIconWidget(
              imagePath: 'assets/images/empty-search.png',
              width: 300,
              height: 300,
            ),
            VSpacing.sm,
            AutoSizeText(
              "Try a different filter or refresh!",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: TColor.petRock,
                    fontSize: 16,
                  ),
            ),
            VSpacing.sm,
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.read<EventCubit>().fetchInitialEvents(),
                borderRadius: TBorderRadius.md,
                child: Ink(
                  decoration: BoxDecoration(
                    color: TColor.poppySurprise,
                    borderRadius: TBorderRadius.md,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      "Refresh",
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
                onTap: () {
                  try {
                    context.read<EventCubit>().fetchInitialEvents();
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
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
