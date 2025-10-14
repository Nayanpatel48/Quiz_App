// This code is like a manager for your user data. It handles all the communication between
// your app's screen and the server where the user information is stored.

// Think of it this way:

// Your App Screen (UI) is the customer. 🧍
// This UserViewModel is the restaurant manager. 🧑‍💼
// The Server/API is the kitchen. 🍳
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/Dart/model/dart_questions_model.dart';
import 'package:repradar/Dart/model/history_dart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DartViewModel extends ChangeNotifier {
  //1. create and configure your main app's connection with your app's server
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://127.0.0.1:8000'),
  ); //FastAPI Url

  //2. we'll store all the Dart related questions from our database inside list
  List<DartQuestionsModel> questions = [];

  //3. keep the track of loading state
  bool isLoading = false;

  //4. store the answers selected by the user during the test
  final Map<int, String> _userAnswers = {};

  //5. getter method for user's answers
  Map<int, String> getUserAnswers() {
    return _userAnswers;
  }

  //6. function to record answers given by user
  void recordAnswer(int questionId, String questionAnswer) {
    _userAnswers[questionId + 1] = questionAnswer;
  }

  //7. function to retrieve previously selected answer
  String? getPreviouslySelectedAns(int questionId) {
    return _userAnswers[questionId];
  }

  //8. calculating final score
  void calculateFinalScore() {
    //step 1 : convert Questions model list into Map<int, String> format
    Map<int, String> answerDictionary = {
      for (var question in questions) question.id: question.answer,
    };

    //step 2 : sort the user answers
    List<int> sortedKeys = _userAnswers.keys.toList()..sort();
    Map<int, String> sortedUserAnswers = {
      for (var key in sortedKeys) key: _userAnswers[key]!,
    };

    //step 3 : compare both using list & then calculate the total score
    int totalScore = 0;
    int totalQuestions = questions.length;

    //iterating keys of the answer dictionary
    for (var questionId in answerDictionary.keys) {
      //get the correct answer by using id
      final correctAnswer = answerDictionary[questionId];

      //get the user selected answer by using id
      final userSelectedAnswer = sortedUserAnswers[questionId];

      //compare both the userSelectedAnswer & correctAnswer
      if (correctAnswer != null &&
          userSelectedAnswer != null &&
          correctAnswer.toLowerCase() == userSelectedAnswer.toLowerCase()) {
        totalScore++;
        print('Q${questionId} : Correct! (Answer : $correctAnswer)');
      } else {
        print('Q${questionId} : Incorrect! (Answer : $correctAnswer)');
      }

      //step 4. assign it to the finalScore variable
      finalScore = totalScore;
      notifyListeners();
    }
  }

  //9. store final score
  int? finalScore;

  Future<void> getDartQuestions() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get('/questions/dart');

      print(response.data);

      // creating JSON list to Dart object list using for loop
      for (var element in response.data) {
        //create dart model object
        final object = DartQuestionsModel.fromJson(element);

        //add this object into list
        questions.add(object);
      }

      print(questions);
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
