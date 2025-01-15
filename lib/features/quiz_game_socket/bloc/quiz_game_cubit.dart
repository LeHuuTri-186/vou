import 'package:bloc/bloc.dart';
import 'package:vou/features/quiz_game_socket/data/answer_result.dart';
import 'package:vou/features/quiz_game_socket/data/question.dart';
import 'package:vou/features/quiz_game_socket/data/quiz_summary.dart';
import '../data/quiz_game_socket_service.dart';

part 'quiz_game_state.dart';

class QuizGameCubit extends Cubit<QuizGameState> {
  final QuizGameSocketService _socketService;

  QuizGameCubit(this._socketService) : super(QuizGameInitial());

  void connectToGame({required String gameOfEventId}) {
    emit(QuizGameLoading());

    try {
      _socketService.connect();

      _socketService.joinGame(gameOfEventId: gameOfEventId);

      _socketService.listenToEvent('quiz-started', (data) {
        emit(QuizGameStarted(data));
      });

      _socketService.listenToEvent('quiz-nexted', (data) {
        QuestionModel question = QuestionModel.fromJson(data as Map<String, dynamic>);

        emit(QuizGameQuestion(question));
      });

      _socketService.listenToEvent('quiz-ended', (data) {
        QuizSummary quizSummary = QuizSummary.fromJson(data as Map<String, dynamic>);
        emit(QuizGameEnded(quizSummary));
      });

      _socketService.listenToEvent('user-result', (data) {
        AnswerResultModel result = AnswerResultModel.fromJson(data as Map<String, dynamic>);

        emit(QuizResult(result));
      });

      emit(QuizGameConnected());
    } catch (e) {
      emit(QuizGameError("Failed to connect: ${e.toString()}"));
      _socketService.dispose();
    }
  }

  void submitAnswer({
    required String questionId,
    required String choice,
    required String gameEventId,
  }) {
    try {
      emit(QuizGameSubmittingAnswer());

      _socketService.submitAnswer(
        questionId: questionId,
        choice: choice,
        gameOfEventId: gameEventId,
      );

      emit(QuizGameAnswerSubmitted());
    } catch (e) {
      emit(QuizGameError("Failed to submit answer: ${e.toString()}"));
    }
  }

  void disconnect() {
    try {
      _socketService.disconnect();
      _socketService.dispose();
      emit(QuizGameDisconnected());
    } catch (e) {
      emit(QuizGameError("Failed to disconnect: ${e.toString()}"));
    }
  }
}
