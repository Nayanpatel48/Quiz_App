class HistoryPythonModel {
  final String testName;
  final int testScore;

  HistoryPythonModel({required this.testName, required this.testScore});

  Map<String, dynamic> toJson() => {'test_name': testName, 'score': testScore};
}
