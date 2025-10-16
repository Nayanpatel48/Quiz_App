import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/Dart/model/dart_questions_model.dart';
import 'package:repradar/Dart/model/history_dart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DartViewModel extends ChangeNotifier {
  // create and configure your main app's connection with your app's server
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000'));
  List<DartQuestionsModel> questions = [];
  bool isLoading = false;
  final Map<int, String> _userAnswers = {};

  Map<int, String> getUserAnswers() {
    return _userAnswers;
  }

  void recordAnswer(int questionId, String questionAnswer) {
    _userAnswers[questionId + 1] = questionAnswer;
    notifyListeners();
  }

  String? getPreviouslySelectedAns(int questionId) {
    return _userAnswers[questionId];
  }

  void calculateFinalScore() {
    Map<int, String> answerDictionary = {
      for (var question in questions) question.id: question.answer,
    };

    List<int> sortedKeys = _userAnswers.keys.toList()..sort();
    Map<int, String> sortedUserAnswers = {
      for (var key in sortedKeys) key: _userAnswers[key]!,
    };

    int totalScore = 0;

    for (var questionId in answerDictionary.keys) {
      final correctAnswer = answerDictionary[questionId];
      final userSelectedAnswer = sortedUserAnswers[questionId];

      if (correctAnswer != null &&
          userSelectedAnswer != null &&
          correctAnswer.toLowerCase() == userSelectedAnswer.toLowerCase()) {
        totalScore++;
      }

      finalScore = totalScore;
      notifyListeners();
    }
  }

  int? finalScore;

  Future<void> getDartQuestions() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get('/questions/dart');

      for (var element in response.data) {
        final object = DartQuestionsModel.fromJson(element);
        questions.add(object);
      }
    } catch (e) {
      print('Error during fetching dart questions : $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> storeHistoryOfDart(HistoryDartModel model) async {
    isLoading = true;
    notifyListeners();

    //fetching JWT from sharedPrefrences
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');

    try {
      final response = await _dio.post(
        '/history/save',
        options: Options(
          headers: {
            // Standard JWT practice: 'Bearer' space 'Token'
            'Authorization': 'Bearer $token',
          },
        ),
        data: model.toJson(),
      );

      print('Data ${response.data} is saved into database.');
    } catch (e) {
      print('Error during saving history to the database : $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
