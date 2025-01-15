import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/features/event/presentation/widgets/game_icon.dart';
import 'package:vou/features/shaker_game/bloc/puzzle_start_cubit.dart';
import 'package:vou/features/shaker_game/bloc/puzzle_start_state.dart';
import 'package:vou/features/shaker_game/presentation/widgets/jigsaw_piece.dart';
import 'package:vou/shared/styles/appbar.dart';
import 'package:vou/shared/styles/border_radius.dart';

import '../../../../shared/styles/box_shadow.dart';
import '../../../../shared/styles/horizontal_spacing.dart';
import '../../../../shared/styles/vertical_spacing.dart';
import '../../../../shared/widgets/image_icon.dart';
import '../../../../theme/color/colors.dart';
import '../../../event/domain/entities/game_in_event.dart';
import '../widgets/image_piece.dart';

class PuzzleStartPage extends StatelessWidget {
  const PuzzleStartPage({super.key, required this.game});

  final GameInEvent game;

  @override
  Widget build(BuildContext context) {
    final startCubit = context.read<PuzzleStartCubit>();
    startCubit.joinGame(gameId: game.id);
    startCubit.loadPuzzle(gameId: game.id, eventId: game.eventId);
    return Scaffold(
      appBar: TAppBar.buildAppBar(context: context, title: game.name),
      body: BlocBuilder<PuzzleStartCubit, PuzzleStartState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(game.image),
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
                                  gameInEvent: game,
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
                    Row(
                      mainAxisAlignment: state is PuzzleStartLoaded
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      children: [
                        if (state is PuzzleStartLoaded)
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
                          onPressed: () {
                            context.push("/shaker-game/play", extra: game);
                          },
                          child: Text(
                            "Play",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: TColor.doctorWhite, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    VSpacing.sm,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Puzzle",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    if (state is PuzzleStartLoaded)
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: TBorderRadius.md,
                              color: TColor.poppySurprise,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ImagePiecesGrid(
                                imageUrl: state.puzzleGame.puzzleImage,
                                totalPieces: state.puzzleGame.sizeX *
                                    state.puzzleGame.sizeY,
                                scale: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    VSpacing.sm,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Your pieces",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    if (state is PuzzleStartLoaded)
                      state.userPuzzles.isNotEmpty
                          ? Builder(
                            builder: (context) {
                              state.userPuzzles.sort((a, b) => a.order.compareTo(b.order));
                              return Column(
                                  children: [
                                    Wrap(
                                      children: state.userPuzzles
                                          .map(
                                            (piece) => Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  JigsawPiece(
                                                    scale: 2,
                                                      imageUrl: state
                                                          .puzzleGame.puzzleImage,
                                                      index: piece.order,
                                                      totalPieces:
                                                          state.puzzleGame.sizeX *
                                                              state.puzzleGame.sizeY),
                                                  HSpacing.md,
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: AutoSizeText(
                                                      '${piece.amount} piece(s)',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    VSpacing.sm,
                                    if (!state.userPuzzles.any((p) => p.amount < 1))
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        shape: const WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius: TBorderRadius.sm),
                                        ),
                                        backgroundColor: WidgetStatePropertyAll(
                                            TColor.poppySurprise),
                                      ),
                                      onPressed: () {
                                        startCubit.exchange(gameId: game.id, eventId: game.eventId);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text(
                                          "Trade",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color: TColor.doctorWhite,
                                                  fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                            }
                          )
                          : const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                VSpacing.sm,
                                ImageIconWidget(
                                  imagePath: 'assets/images/hunt-event.png',
                                  width: 300,
                                  height: 300,
                                ),
                                VSpacing.sm,
                                Text("Play game to get some pieces first!"),
                              ],
                            )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
