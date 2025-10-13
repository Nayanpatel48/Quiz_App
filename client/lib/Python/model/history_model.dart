class HistoryPythonModel {
  //properties
  final String testName;
  final int testScore;

  //constructor
  HistoryPythonModel({required this.testName, required this.testScore});

  //Dart object to JSON converter method
  Map<String, dynamic> toJson() => {'test_name': testName, 'score': testScore};
}
