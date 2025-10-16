class PythonQuestionsModel {
  final int id;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String answer;

  PythonQuestionsModel({
    required this.id,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.answer,
  });

  factory PythonQuestionsModel.fromJson(Map<String, dynamic> json) =>
      PythonQuestionsModel(
        id: json['id'] as int,
        question: json['question'] as String,
        optionA: json['option_a'] as String,
        optionB: json['option_b'] as String,
        optionC: json['option_c'] as String,
        optionD: json['option_d'] as String,
        answer: json['answer'] as String,
      );
}
