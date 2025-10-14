// This code is like a manager for your user data. It handles all the communication between
// your app's screen and the server where the user information is stored.

// Think of it this way:

// Your App Screen (UI) is the customer. 🧍
// This UserViewModel is the restaurant manager. 🧑‍💼
// The Server/API is the kitchen. 🍳

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/Python/model/history_model.dart';
import 'package:repradar/Python/model/python_questions_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PythonViewModel extends ChangeNotifier {
  //1. This line creates & configure your app's main connection to your backend server.
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://127.0.0.1:8000'),
  ); //FastAPI URL

  //2. To store all the python related questions available in our postgres database
  List<PythonQuestionsModel> questionsList = [];

  //3. for keep track of loading state
  bool isLoading = false;

  //4. store the selected answers by the user during test in view model
  final Map<int, String> _userAnswers = {};

  //5. getter method for userAnsers
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

  //8. calculating final score
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

    //step 3 : compare both lists using loop & calculate the total score of user
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

    print('\n--- Results ---');
    print('Total Questions: $totalQuestions');
    print('Correct Answers: $totalScore');

    //step 4 : assign it to the finalScore variable
    finalScore = totalScore;
    notifyListeners();
  }

  //9. store final score
  int? finalScore;

  Future<void> getPythonQuestions() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get('/questions/py');

      print(response.data);

      // creating JSON list to Dart object list using for loop
      for (var element in response.data) {
        //create dart model object
        final object = PythonQuestionsModel.fromJson(element);

        //add this object into list
        questionsList.add(object);
      }

      print(questionsList);
    } catch (e) {
      print('Error during fetching the python questions $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> storeHistoryofPython(HistoryPythonModel model) async {
    isLoading = true;
    notifyListeners();

    //copy the JWT token from shared preferences
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

      print('Data ${response.data} is stored in database');
    } catch (e) {
      print('Error during history saving is $e');
    }
    isLoading = false;
    notifyListeners();
  }
}
