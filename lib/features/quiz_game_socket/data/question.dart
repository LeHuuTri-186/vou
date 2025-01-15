class QuestionModel {
  final String id;
  final String content;
  final List<OptionModel> options;

  QuestionModel({
    required this.id,
    required this.content,
    required this.options,
  });

  // Factory constructor for mapping from JSON
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      content: json['content'],
      options: (json['options'] as List)
          .map((option) => OptionModel.fromJson(option))
          .toList(),
    );
  }

  // Method to convert model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}

class OptionModel {
  final String choice;
  final String content;

  OptionModel({
    required this.choice,
    required this.content,
  });

  // Factory constructor for mapping from JSON
  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      choice: json['choice'],
      content: json['content'],
    );
  }

  // Method to convert model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'choice': choice,
      'content': content,
    };
  }
}
