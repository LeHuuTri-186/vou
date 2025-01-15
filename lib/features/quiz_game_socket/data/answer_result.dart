class AnswerResultModel {
  final String questionId;
  final bool isCorrect;
  final bool isAnswered;
  final int score;

  AnswerResultModel({
    required this.questionId,
    required this.isCorrect,
    required this.isAnswered,
    required this.score,
  });

  // Factory constructor for mapping from JSON
  factory AnswerResultModel.fromJson(Map<String, dynamic> json) {
    return AnswerResultModel(
      questionId: json['questionId'],
      isCorrect: json['isCorrect'],
      isAnswered: json['isAnswered'],
      score: json['score'],
    );
  }

  // Method to convert model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'isCorrect': isCorrect,
      'isAnswered': isAnswered,
      'score': score,
    };
  }
}
