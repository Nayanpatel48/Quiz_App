class HistoryDartModel {
  final String testName;
  final int testScore;

  HistoryDartModel({required this.testName, required this.testScore});

  Map<String, dynamic> toJson() => {'test_name': testName, 'score': testScore};
}
