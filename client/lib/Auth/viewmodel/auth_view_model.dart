// This code is like a manager for your user data. It handles all the communication between
// your app's screen and the server where the user information is stored.

// Think of it this way:

// Your App Screen (UI) is the customer. 🧍
// This UserViewModel is the restaurant manager. 🧑‍💼
// The Server/API is the kitchen. 🍳

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/Auth/model/auth_response_model.dart';
import 'package:repradar/Auth/model/user_login_model.dart';
import 'package:repradar/Auth/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  //1. This line creates & configure your app's main connection to your backend server.
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://127.0.0.1:8000'),
  ); //FastAPI URL

  //2. To store all the users available in our postgres database
  List<User> users = [];

  //3. for keep track of loading state
  bool isLoading = false;

  //4. this is to show to the user
  String errorMessage = '';

  //5. for user created successfully
  bool isUserCreated = false;

  //6. for user logged in successfully
  bool isUserLoggedIn = false;

  //7. create new user
  Future<void> createUser(User user) async {
    print(user.toJson());

    //setting isLoading to true in order to show loading indicator on screen
    isLoading = true;
    try {
      //send request to the server using dio package
      final response = await _dio.post('/auth/create', data: user.toJson());

      print(response.data);

      // if the user is successfully created then we can add the user into our users list
      // here response.data is our newly created user object in the database
      users.add(User.fromJson(response.data));

      // notify all the widgets that are listening so they can rebuild them selves
      notifyListeners();

      isUserCreated = true;
    } catch (e) {
      errorMessage = 'Sign up failed please check your credentials!';
      print('Error during account creation $e');
    }

    //setting isLoading to false in order to hide loading indicator on screen & notify the
    //listners in the application
    isLoading = false;
    notifyListeners();
  }

  //8. login user
  Future<void> loginUser(UserLoginModel user) async {
    // we are setting isLoading equals true so the screen can show loading indicator while
    // background process happens
    isLoading = true;

    notifyListeners();

    try {
      // sending request to the server for login user
      final response = await _dio.post('/auth/login', data: user.toJson());

      print(response.data);

      // currently logged in user data
      // we use AuthResponse model so that we can convert the response of login end point
      // into appropriat dart object format.
      final currentlyLoggedInUserData = AuthResponseModel.fromJson(
        response.data,
      );

      // after user has been successfully logged in
      isUserLoggedIn = true;

      print('Currently logged in user data : $currentlyLoggedInUserData');

      //store it in the shared preferences because we are going to keep logged in user logged in
      final pref = await SharedPreferences.getInstance();
      await pref.setString('token', currentlyLoggedInUserData.token);
    } catch (e) {
      errorMessage = 'User login failed! please check credentials';
      print('Login is failed $e');
    }

    //once the user logged in successfull stop loading & tell the listners of application
    isLoading = false;
    notifyListeners();
  }
}
