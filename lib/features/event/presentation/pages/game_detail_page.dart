import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/features/event/bloc/game_detail_cubit.dart';
import 'package:vou/features/event/bloc/game_detail_state.dart';
import 'package:vou/features/event/presentation/widgets/game_icon.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/box_shadow.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';
import 'package:vou/shared/widgets/loading_widget.dart';

import '../../../../shared/styles/appbar.dart';
import '../../../../shared/styles/horizontal_spacing.dart';
import '../../../../shared/widgets/image_icon.dart';
import '../../../../theme/color/colors.dart';

class GameDetailPage extends StatelessWidget {
  const GameDetailPage(
      {super.key, required this.eventGameId, required this.eventId});
  final String eventGameId;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    final GameDetailCubit cubit = context.read<GameDetailCubit>();

    cubit.loadGameDetail(gameId: eventGameId, eventId: eventId);
    return BlocBuilder<GameDetailCubit, GameDetailState>(builder: (_, state) {
      if (state is GameDetailError) {}

      if (state is GameDetailLoaded) {
        return Scaffold(
          appBar: TAppBar.buildAppBar(context: context, title: state.game.name),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(state.game.image),
                        fit: BoxFit.fitWidth),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: TColor.doctorWhite,
                            boxShadow: [TBoxShadow.normalBoxShadow],
                            borderRadius: TBorderRadius.md,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GameIcon(
                              gameInEvent: state.game,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                VSpacing.md,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          Text(
                            "Chances: ${state.turns}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 20),
                          ),
                          HSpacing.sm,
                          const ImageIconWidget(
                              imagePath: "assets/images/lives.png"),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: const WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: TBorderRadius.sm)),
                          backgroundColor:
                              WidgetStatePropertyAll(TColor.poppySurprise),
                        ),
                        onPressed: state.type.status == "ACTIVE"
                            ? () {
                                debugPrint(state.game.gameId);
                                state.type.name.toLowerCase().contains("puzzle")
                                    ? context.push("/shaker-game",
                                        extra: state.game)
                                    : context.push("/quiz-game",
                                        extra: state.game);
                              }
                            : () {},
                        child: Text(
                          "Play game",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: TColor.doctorWhite, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                VSpacing.md,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(),
                ),
                VSpacing.sm,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Game type",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                ),
                VSpacing.sm,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${state.type.name}: ${state.type.description}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
                VSpacing.sm,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                ),
                VSpacing.sm,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.game.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
                VSpacing.sm,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "How to play",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                ),
                VSpacing.sm,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.game.guide,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Scaffold(
        body: Center(
          child: LoadingWidget.twistingDotsLoadIndicator(),
        ),
      );
    });
  }
}
