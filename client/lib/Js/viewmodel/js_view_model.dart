// This code is like a manager for your user data. It handles all the communication between
// your app's screen and the server where the user information is stored.

// Think of it this way:

// Your App Screen (UI) is the customer. 🧍
// This UserViewModel is the restaurant manager. 🧑‍💼
// The Server/API is the kitchen. 🍳

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/Js/model/history_js_model.dart';
import 'package:repradar/Js/model/js_questions_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JsViewModel extends ChangeNotifier {
  //1. this line creates & configures your main app's connection with your app's backend
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://127.0.0.1:8000'),
  ); //FAST API Url

  //2. list all the javascript related questions available in the database
  List<JsQuestionsModel> questionsList = [];

  //3. keep track of loading state
  bool isLoading = false;

  //4.store the selected answers by user during the test
  final Map<int, String> _userAnswers = {};

  //5. getter method for user answers
  Map<int, String> getUserAnswers() {
    return _userAnswers;
  }

  //6. function to record an answer
  void recordAnswer(int questionId, String selectedAnswer) {
    _userAnswers[questionId + 1] = selectedAnswer;

    // This tells the UI to rebuild to show the correct state
    notifyListeners();
  }

  //7. function to retrieve the previously selected answer
  String? getSelectedOption(int questionId) {
    return _userAnswers[questionId];
  }

  //8. calculating the final score
  void calculateFinalScore() {
    //step 1 : convert Questions models list into Map<int, String> format
    Map<int, String> answerDictionary = {
      for (var question in questionsList) question.id: question.answer,
    };

    //step 2 : sort the user answers
    List<int> sortedKeys = _userAnswers.keys.toList()..sort();
    Map<int, String> sortedUserAnswers = {
      for (var key in sortedKeys) key: _userAnswers[key]!,
    };

    //step 3 : compare both using loop & calculate the total score of user
    int totalScore = 0;
    int totalQuestions = answerDictionary.length;
    print(answerDictionary);
    print(sortedUserAnswers);

    //iterating keys of the answerDictionary
    for (var questionId in answerDictionary.keys) {
      //get the correct answer from the current ID
      final correctAnswer = answerDictionary[questionId];

      //get the user's answer from the current ID
      final userAnswer = sortedUserAnswers[questionId];

      // check if the both answers are not null & equal with both converted to lower case
      if (correctAnswer != null &&
          userAnswer != null &&
          userAnswer.toLowerCase() == correctAnswer.toLowerCase()) {
        totalScore++;
        print('Q$questionId: Correct! (Answer: $correctAnswer)');
      } else {
        print(
          'Q$questionId: Incorrect. (Correct: $correctAnswer, User: $userAnswer)',
        );
      }
    }

    double percentage = (totalScore / totalQuestions) * 100;

    print('\n--- Results ---');
    print('Total Questions: $totalQuestions');
    print('Correct Answers: $totalScore');
    print('Score Percentage: ${percentage.toStringAsFixed(2)}%');

    //step 4 : assign it to the finalScore variable
    finalScore = totalScore;
    notifyListeners();
  }

  //9. Store final score
  int? finalScore;

  Future<void> getJavaScriptQuestions() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await _dio.get('/questions/js');

      // creating JSON list to Dart object list using for loop
      for (var element in response.data) {
        //create dart model object
        final object = JsQuestionsModel.fromJson(element);

        //add this object into list
        questionsList.add(object);
      }

      print(questionsList);
    } catch (e) {
      print('Error during fetching JS questions $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> storeHistoryOfJs(HistoryJsModel model) async {
    isLoading = true;
    notifyListeners();

    //extract JWT toke from shared prefrences to pass to the server
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

      print('Data ${response.data} is stored in the database.');
    } catch (e) {
      print('EXception during history storing is $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
