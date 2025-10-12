import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/Settings/model/current_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends ChangeNotifier {
  //1. This line creates & configure your app's main connection to your backend server.
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://127.0.0.1:8000'),
  ); //FastAPI URL

  //2. Keep track of loading state
  bool isLoading = false;

  //3. for storing currently logged in user
  CurrentUserModel? currentlyLoggedInUserData;

  Future<void> getCurrentlyLoggedInUser() async {
    isLoading = true;
    notifyListeners();

    //1. read the token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      // Make a GET request and send the token in the Authorization Header
      final response = await _dio.get(
        '/auth/current_user',
        options: Options(
          headers: {
            // Standard JWT practice: 'Bearer' space 'Token'
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('Data of currently logged in user is : ${response.data}');

      currentlyLoggedInUserData = CurrentUserModel.fromJson(response.data);
    } catch (e) {
      print('During fetching currently logged in user is $e');
    }
    isLoading = false;
    notifyListeners();
  }
}
