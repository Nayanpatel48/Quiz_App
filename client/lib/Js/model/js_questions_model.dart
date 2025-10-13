class JsQuestionsModel {
  // properties of the class
  final int id;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String answer;

  //constructor
  JsQuestionsModel({
    required this.id,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.answer,
  });

  //Json to Dart conversion
  factory JsQuestionsModel.fromJson(Map<String, dynamic> json) =>
      JsQuestionsModel(
        id: json['id'],
        question: json['question'],
        optionA: json['option_a'],
        optionB: json['option_b'],
        optionC: json['option_c'],
        optionD: json['option_d'],
        answer: json['answer'],
      );
}
