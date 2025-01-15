import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/features/event/domain/entities/game_in_event.dart';
import 'package:vou/features/quiz_game_socket/bloc/quiz_game_cubit.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';
import 'package:vou/shared/widgets/image_icon.dart';
import 'package:vou/shared/widgets/loading_widget.dart';

import '../../../core/constants.dart';
import '../../../shared/styles/border_radius.dart';
import '../../../shared/styles/horizontal_spacing.dart';
import '../../../theme/color/colors.dart';
import '../../quiz/presentation/widgets/answer_button.dart';

class QuizGamePage extends StatelessWidget {
  const QuizGamePage({super.key, required this.gameInEvent});

  final GameInEvent gameInEvent;

  @override
  Widget build(BuildContext context) {
    final quizCubit = context.read<QuizGameCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              quizCubit.disconnect();
              context.pop();
            },
            child: Icon(Icons.arrow_back, color: TColor.doctorWhite,),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: AutoSizeText(gameInEvent.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: TColor.doctorWhite)),
      ),
      backgroundColor: TColor.daJuice,
      body: BlocBuilder<QuizGameCubit, QuizGameState>(
        builder: (BuildContext context, QuizGameState state) {
          if (state is QuizGameEnded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: AutoSizeText(
                    textAlign: TextAlign.center,
                    "Rank: ${state.data.userResult.top}",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: TColor.doctorWhite),
                  ),
                ),
                AutoSizeText(
                  textAlign: TextAlign.center,
                  "Your score: ${state.data.userResult.score}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: TColor.doctorWhite),
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: const WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: TBorderRadius.sm)),
                      backgroundColor:
                          WidgetStatePropertyAll(TColor.poppySurprise),
                    ),
                    onPressed: () {
                      quizCubit.disconnect();
                    },
                    child: Text(
                      "Leave",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: TColor.doctorWhite, fontSize: 18),
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is QuizResult) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  textAlign: TextAlign.center,
                  state.data.isCorrect ? "Congrats!" : "Better luck next time!",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: TColor.doctorWhite),
                ),
                VSpacing.md,
                ImageIconWidget(
                  imagePath: state.data.isCorrect
                      ? "assets/images/congrats.png"
                      : "assets/images/study.png",
                  width: 100,
                  height: 100,
                ),
                VSpacing.md,
                AutoSizeText(
                  textAlign: TextAlign.center,
                  "Your score: ${state.data.score}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: TColor.doctorWhite),
                ),
              ],
            );
          }

          if (state is QuizGameAnswerSubmitted) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  textAlign: TextAlign.center,
                  "Be prepared!",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: TColor.doctorWhite),
                ),
                VSpacing.md,
                Center(
                  child: LoadingWidget.twistingDotsLoadIndicator(),
                )
              ],
            );
          }

          if (state is QuizGameSubmittingAnswer) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  textAlign: TextAlign.center,
                  "Lightning Speed!",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: TColor.doctorWhite),
                ),
                VSpacing.md,
                Center(
                  child: LoadingWidget.twistingDotsLoadIndicator(),
                )
              ],
            );
          }
          if (state is QuizGameQuestion) {
            Center(
              child: Container(
                margin: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      textAlign: TextAlign.center,
                      state.data.content,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                    ),
                    VSpacing.lg,
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: AnswerButton(
                                      color: $constants.answerColors[0],
                                      text:
                                          'A: 1',
                                      onTap: () {
                                        quizCubit.submitAnswer(
                                          questionId: state.data.id,
                                          choice: state.data.options[0].choice,
                                          gameEventId: gameInEvent.id,
                                        );
                                      },
                                    ),
                                  ),
                                  HSpacing.sm,
                                  Flexible(
                                    child: AnswerButton(
                                      color: $constants.answerColors[1],
                                      text:
                                          'B: 2',
                                      onTap: () {
                                        quizCubit.submitAnswer(
                                          questionId: state.data.id,
                                          choice: state.data.options[1].choice,
                                          gameEventId: gameInEvent.id,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              VSpacing.sm, // Space between rows
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: AnswerButton(
                                      color: $constants.answerColors[2],
                                      text:
                                          'C: 3',
                                      onTap: () {
                                        quizCubit.submitAnswer(
                                          questionId: state.data.id,
                                          choice: state.data.options[2].choice,
                                          gameEventId: gameInEvent.id,
                                        );
                                      },
                                    ),
                                  ),
                                  HSpacing.sm,
                                  Flexible(
                                    child: AnswerButton(
                                      color: $constants.answerColors[3],
                                      text:
                                          'D. 5',
                                      onTap: () {
                                        quizCubit.submitAnswer(
                                          questionId: state.data.id,
                                          choice: state.data.options[3].choice,
                                          gameEventId: gameInEvent.id,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is QuizGameStarted) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  textAlign: TextAlign.center,
                  "Get ready! The game starts now",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: TColor.doctorWhite),
                ),
                VSpacing.md,
                Center(
                  child: LoadingWidget.twistingDotsLoadIndicator(),
                )
              ],
            );
          }
          if (state is QuizGameInitial) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  textAlign: TextAlign.center,
                  "Click to join Quiz!",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: TColor.doctorWhite),
                ),
                VSpacing.md,
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: const WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: TBorderRadius.sm)),
                      backgroundColor:
                          WidgetStatePropertyAll(TColor.poppySurprise),
                    ),
                    onPressed: () {
                      quizCubit.connectToGame(gameOfEventId: gameInEvent.id);
                    },
                    child: Text(
                      "Play",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: TColor.doctorWhite, fontSize: 18),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is QuizGameConnected) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  textAlign: TextAlign.center,
                  "Connected!",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: TColor.doctorWhite),
                ),
                AutoSizeText(
                  textAlign: TextAlign.center,
                  "Waiting for game to start!",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: TColor.doctorWhite),
                ),
                Center(
                  child: LoadingWidget.twistingDotsLoadIndicator(),
                ),
              ],
            );
          }

          return Center(
            child: LoadingWidget.twistingDotsLoadIndicator(),
          );
        },
      ),
    );
  }
}
