class HistoryModel {
  final int id;
  final String testName;
  final int userId;
  final int score;
  final String createdAt;

  HistoryModel({
    required this.id,
    required this.testName,
    required this.userId,
    required this.score,
    required this.createdAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    id: json['id'],
    testName: json['test_name'],
    userId: json['user_id'],
    score: json['score'],
    createdAt: json['created_at'],
  );
}
