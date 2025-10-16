import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repradar/History/model/history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryViewModel extends ChangeNotifier {
  // configure & create the connection of your main app with server/ backend
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8000'));
  List<HistoryModel> historyObjects = [];
  bool isLoading = false;

  Future<void> getHistoryOfUser() async {
    isLoading = true;
    notifyListeners();

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

      for (var history in response.data) {
        final model = HistoryModel.fromJson(history);

        historyObjects.add(model);
      }
    } catch (e) {
      print('Error during fetching history is : $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
