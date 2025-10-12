// This code is like a manager for your user data. It handles all the communication between
// your app's screen and the server where the user information is stored.

// Think of it this way:

// Your App Screen (UI) is the customer. 🧍
// This UserViewModel is the restaurant manager. 🧑‍💼
// The Server/API is the kitchen. 🍳

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/Python/model/python_questions_model.dart';

class PythonViewModel extends ChangeNotifier {
  //1. This line creates & configure your app's main connection to your backend server.
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://127.0.0.1:8000'),
  ); //FastAPI URL

  //2. To store all the users available in our postgres database
  List<PythonQuestionsModel> questionsList = [];

  //3. for keep track of loading state
  bool isLoading = false;

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
}
