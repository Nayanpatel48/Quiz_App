// This code is like a manager for your user data. It handles all the communication between
// your app's screen and the server where the user information is stored.

// Think of it this way:

// Your App Screen (UI) is the customer. 🧍
// This UserViewModel is the restaurant manager. 🧑‍💼
// The Server/API is the kitchen. 🍳

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/History/model/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryViewModel extends ChangeNotifier {
  //1. configure & create the connection of your main app with server/ backend
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000'));

  //2. store all the history objects in the list
  List<HistoryModel> historyObjects = [];

  //3. for keeping track of loading state
  bool isLoading = false;

  Future<void> getHistoryOfUser() async {
    isLoading = true;
    notifyListeners();

    //getting JWT token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await _dio.get(
        '/history/history',
        options: Options(
          headers: {
            // Standard JWT practice: 'Bearer' space 'Token'
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // creating JSON list to Dart object list using for loop
      for (var history in response.data) {
        //create a dart model object
        final model = HistoryModel.fromJson(history);

        //add this object into list
        historyObjects.add(model);
      }
      print(historyObjects);
    } catch (e) {
      print('Error during fetching history is : $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
