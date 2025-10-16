class DartQuestionsModel {
  final int id;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String answer;

  DartQuestionsModel({
    required this.id,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.answer,
  });

  factory DartQuestionsModel.fromJson(Map<String, dynamic> json) =>
      DartQuestionsModel(
        id: json['id'],
        question: json['question'],
        optionA: json['option_a'],
        optionB: json['option_b'],
        optionC: json['option_c'],
        optionD: json['option_d'],
        answer: json['answer'],
      );
}
