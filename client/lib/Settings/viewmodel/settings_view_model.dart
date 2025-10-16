import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/Settings/model/current_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends ChangeNotifier {
  // This line creates & configure your app's main connection to your backend server.
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000'));

  bool isLoading = false;
  CurrentUserModel? currentlyLoggedInUserData;

  Future<void> getCurrentlyLoggedInUser() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await _dio.get(
        '/auth/current_user',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      currentlyLoggedInUserData = CurrentUserModel.fromJson(response.data);
    } catch (e) {
      print('During fetching currently logged in user is $e');
    }
    isLoading = false;
    notifyListeners();
  }
}
