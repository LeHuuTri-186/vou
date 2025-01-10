import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vou/shared/styles/horizontal_spacing.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';
import 'package:vou/utils/constants.dart';
import '../../data/questions.dart';
import '../widgets/answer_button.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              textAlign: TextAlign.center,
              currentQuestion.text,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: AnswerButton(
                              color: $constants.answerColors[0],
                              text: currentQuestion.answers[0],
                              onTap: () {
                                answerQuestion(currentQuestion.answers[0]);
                              },
                            ),
                          ),
                          HSpacing.sm,
                          Flexible(
                            child: AnswerButton(
                              color: $constants.answerColors[1],
                              text: currentQuestion.answers[1],
                              onTap: () {
                                answerQuestion(currentQuestion.answers[1]);
                              },
                            ),
                          ),
                        ],
                      ),
                      VSpacing.sm, // Space between rows
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: AnswerButton(
                              color: $constants.answerColors[2],
                              text: currentQuestion.answers[2],
                              onTap: () {
                                answerQuestion(currentQuestion.answers[2]);
                              },
                            ),
                          ),
                          HSpacing.sm,
                          Flexible(
                            child: AnswerButton(
                              color: $constants.answerColors[3],
                              text: currentQuestion.answers[3],
                              onTap: () {
                                answerQuestion(currentQuestion.answers[3]);
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
}
