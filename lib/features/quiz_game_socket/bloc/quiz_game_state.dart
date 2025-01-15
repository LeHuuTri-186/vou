part of 'quiz_game_cubit.dart';

/// Base State
abstract class QuizGameState {}

/// Initial State
class QuizGameInitial extends QuizGameState {}

class QuizGameLoading extends QuizGameState {}

class QuizGameConnected extends QuizGameState {}

/// State when receiving quiz start event
class QuizGameStarted extends QuizGameState {
  final dynamic data; // Replace `dynamic` with your data model type
  QuizGameStarted(this.data);
}

/// State when receiving a quiz question
class QuizGameQuestion extends QuizGameState {
  final QuestionModel data; // Replace `dynamic` with your data model type
  QuizGameQuestion(this.data);
}

class QuizResult extends QuizGameState {
  final AnswerResultModel data; // Replace `dynamic` with your data model type
  QuizResult(this.data);
}

/// State when the quiz has ended
class QuizGameEnded extends QuizGameState {
  final QuizSummary data; // Replace `dynamic` with your data model type
  QuizGameEnded(this.data);
}

/// State for when an answer is being submitted
class QuizGameSubmittingAnswer extends QuizGameState {}

/// State for when an answer is successfully submitted
class QuizGameAnswerSubmitted extends QuizGameState {}

/// State for when the game is disconnected
class QuizGameDisconnected extends QuizGameState {}

/// Error State
class QuizGameError extends QuizGameState {
  final String message;
  QuizGameError(this.message);
}
