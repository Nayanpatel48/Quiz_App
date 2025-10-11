class PythonQuestionsModel {
  // properties of the class
  final int id;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String answer;

  //constructor
  PythonQuestionsModel({
    required this.id,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.answer,
  });

  //Json to Dart conversion
  factory PythonQuestionsModel.fromJson(Map<String, dynamic> json) =>
      PythonQuestionsModel(
        id: json['id'],
        question: json['question'],
        optionA: json['optionA'],
        optionB: json['optionB'],
        optionC: json['optionC'],
        optionD: json['optionD'],
        answer: json['answer'],
      );
}
