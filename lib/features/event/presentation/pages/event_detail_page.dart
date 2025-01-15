import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/features/event/bloc/game_in_event_cubit.dart';
import 'package:vou/features/event/bloc/game_in_event_state.dart';
import 'package:vou/features/event/domain/entities/event_model.dart';
import 'package:vou/features/event/presentation/widgets/game_button.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/horizontal_spacing.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';
import 'package:vou/shared/widgets/image_icon.dart';
import 'package:vou/shared/widgets/loading_widget.dart';

import '../../../../core/helpers/datetime_formatter.dart';
import '../../../../theme/color/colors.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key, this.eventModel, required this.eventId});
  final EventModel? eventModel;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.read<GameCubit>();

    gameCubit.getAllGameInEvent(eventId: eventId);

    return BlocListener<GameCubit, GameInEventState>(
      child: Scaffold(
        body:
            BlocBuilder<GameCubit, GameInEventState>(builder: (context, state) {
          if (state is GameInEventLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(state.eventModel.image),
                          fit: BoxFit.fitWidth),
                    ),
                    child: const Row(),
                  ),
                  VSpacing.sm,
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: AutoSizeText(
                            state.eventModel.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Flexible(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: const WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: TBorderRadius.sm)),
                              backgroundColor:
                                  WidgetStatePropertyAll(TColor.poppySurprise),
                            ),
                            onPressed: () {
                              context.pop();
                            },
                            child: Text(
                              "Leave",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: TColor.doctorWhite, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            HSpacing.sm,
                            Text(
                              '${DateTimeUtil.formatDateTime(state.eventModel.startDate)} - ${DateTimeUtil.formatDateTime(state.eventModel.endDate)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Icon(Icons.refresh),
                            HSpacing.sm,
                            Text(
                              "${state.eventModel.turnsPerDay} reset per day",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              children: [
                                const ImageIconWidget(
                                    imagePath: "assets/images/lives.png"),
                                HSpacing.sm,
                                Text(
                                  "${state.turns} turns left",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  context.push("/friend/share", extra: state.eventModel.id);
                                },
                                borderRadius: TBorderRadius.md,
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: TColor.tamarama,
                                    borderRadius: TBorderRadius.md,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      "Share your turn",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: TColor.doctorWhite,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Information",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      state.eventModel.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  VSpacing.md,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Games",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: state.gameList
                          .map(
                            (game) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GameButton(
                                gameInEvent: game,
                                onTap: () =>
                                    context.push('/event/$eventId/${game.id}', extra: game.id),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is GameInEventError) {
            return _buildErrorPanel(context);
          }

          return SafeArea(
            child: Center(
              child: LoadingWidget.twistingDotsLoadIndicator(),
            ),
          );
        }),
      ),
      listener: (context, state) {
        if (state is FailedToJoin) {
          context.pop();
        }

        if (state is LeaveEvent) {
          context.pop();
        }
      },
    );
  }

  SafeArea _buildErrorPanel(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                    context
                        .read<GameCubit>()
                        .getAllGameInEvent(eventId: eventId);
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
