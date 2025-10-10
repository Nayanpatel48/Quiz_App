// This code is like a manager for your user data. It handles all the communication between
// your app's screen and the server where the user information is stored.

// Think of it this way:

// Your App Screen (UI) is the customer. 🧍
// This UserViewModel is the restaurant manager. 🧑‍💼
// The Server/API is the kitchen. 🍳

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/Auth/model/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  //1. This line creates & configure your app's main connection to your backend server.
  final Dio _dio = Dio(
    BaseOptions(baseUrl: '"http://127.0.0.1:8000"'),
  ); //FastAPI URL

  //2. To store all the users available in our postgres database
  List<User> users = [];

  final isLoading = false;
}
