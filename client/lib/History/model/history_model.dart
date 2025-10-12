class HistoryModel {
  //properties
  final int id;
  final String testName;
  final int userId;
  final int score;
  final DateTime createdAt;

  //constructor
  HistoryModel({
    required this.id,
    required this.testName,
    required this.userId,
    required this.score,
    required this.createdAt,
  });

  //conversion from JSON to dart object so we can use it for viewing user a history.
  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    id: json['id'],
    testName: json['test_name'],
    userId: json['user_id'],
    score: json['score'],
    createdAt: json['created_at'],
  );
}
