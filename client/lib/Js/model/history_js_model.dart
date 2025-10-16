class HistoryJsModel {
  final String testName;
  final int? testScore;

  HistoryJsModel({required this.testName, required this.testScore});

  Map<String, dynamic> toJson() => {'test_name': testName, 'score': testScore};
}
