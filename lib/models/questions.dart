class QuestionsModal {
  static List<Question> questions = [];
}

class Question {
  final int id;
  final String name;
  final List<String> options;
  final int correctAnswerIndex;
  final String explain;

  Question({
    required this.id,
    required this.name,
    required this.options,
    required this.correctAnswerIndex,
    required this.explain,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json['id'] as int,
        name: json['name'] as String,
        options: (json['options'] as List).cast<String>(),
        correctAnswerIndex: json['correct_answer_index'] as int,
        explain: json['explain'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'options': options,
        'correct_answer_index': correctAnswerIndex,
        'explain': explain,
      };
}
