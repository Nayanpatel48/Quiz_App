import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/Python/model/history_model.dart';
import 'package:repradar/Python/model/python_questions_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PythonViewModel extends ChangeNotifier {
  // This line creates & configure your app's main connection to your backend server.
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000'));

  List<PythonQuestionsModel> questionsList = [];
  bool isLoading = false;
  final Map<int, String> _userAnswers = {};

  Map<int, String> getUserAnswers() {
    return _userAnswers;
  }

  void recordAnswer(int questionId, String selectedAnswer) {
    _userAnswers[questionId + 1] = selectedAnswer;
    // This tells the UI to rebuild to show the correct state
    notifyListeners();
  }

  String? getSelectedOption(int questionId) {
    return _userAnswers[questionId];
  }

  void calculateFinalScore() {
    Map<int, String> answerDictionary = {
      for (var question in questionsList) question.id: question.answer,
    };

    List<int> sortedKeys = _userAnswers.keys.toList()..sort();
    Map<int, String> sortedUserAnswers = {
      for (var key in sortedKeys) key: _userAnswers[key]!,
    };

    int totalScore = 0;
    int totalQuestions = answerDictionary.length;

    for (var questionId in answerDictionary.keys) {
      final correctAnswer = answerDictionary[questionId];
      final userAnswer = sortedUserAnswers[questionId];

      if (correctAnswer != null &&
          userAnswer != null &&
          userAnswer.toLowerCase() == correctAnswer.toLowerCase()) {
        totalScore++;
      }
    }

    finalScore = totalScore;
    notifyListeners();
  }

  int? finalScore;

  Future<void> getPythonQuestions() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get('/questions/py');

      for (var element in response.data) {
        final object = PythonQuestionsModel.fromJson(element);
        questionsList.add(object);
      }
    } catch (e) {
      print('Error during fetching the python questions $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> storeHistoryofPython(HistoryPythonModel model) async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await _dio.post(
        '/history/save',
        data: model.toJson(),
        options: Options(
          headers: {
            // Standard JWT practice: 'Bearer' space 'Token'
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      print('Error during history saving is $e');
    }
    isLoading = false;
    notifyListeners();
  }
}
