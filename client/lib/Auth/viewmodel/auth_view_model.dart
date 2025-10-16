import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/Auth/model/auth_response_model.dart';
import 'package:repradar/Auth/model/user_login_model.dart';
import 'package:repradar/Auth/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  //This line creates & configure your app's main connection to your backend server.
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000'));
  List<User> users = [];
  bool isLoading = false;
  String errorMessage = '';
  bool isUserCreated = false;
  bool isUserLoggedIn = false;

  Future<void> createUser(User user) async {
    isLoading = true;
    try {
      final response = await _dio.post('/auth/create', data: user.toJson());
      users.add(User.fromJson(response.data));

      notifyListeners();
      isUserCreated = true;
    } catch (e) {
      errorMessage = 'Sign up failed please check your credentials!';
      print('Error during account creation $e');
    }

    //setting isLoading to false in order to hide loading indicator on screen & notify the
    //listners in the application.
    isLoading = false;
    notifyListeners();
  }

  //8. login user
  Future<void> loginUser(UserLoginModel user) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.post('/auth/login', data: user.toJson());
      final currentlyLoggedInUserData = AuthResponseModel.fromJson(
        response.data,
      );

      // after user has been successfully logged in
      isUserLoggedIn = true;

      // ignore: avoid_print
      print('Currently logged in user data : $currentlyLoggedInUserData');

      //store it in the shared preferences because we are going to keep logged in user logged in
      final pref = await SharedPreferences.getInstance();
      await pref.setString('token', currentlyLoggedInUserData.token);
    } catch (e) {
      errorMessage = 'User login failed! please check credentials';
      // ignore: avoid_print
      print('Login is failed $e');
    }

    //once the user logged in successfull stop loading & tell the listners of application
    isLoading = false;
    notifyListeners();
  }
}
