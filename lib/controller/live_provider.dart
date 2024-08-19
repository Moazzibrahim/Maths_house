// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/live/live_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LiveProvider extends ChangeNotifier {
  List<Session> allsessions = [];
  int sessionId = 0;
  bool mustBuyNewPackage = false;

  Future<void> getCoursesData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_live'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        if (jsonResponse['message'] == 'Sorry: You Must Buy New Package') {
          mustBuyNewPackage = true;
          allsessions = [];
        } else {
          mustBuyNewPackage = false;

          // Parsing session data
          final sessionsList = jsonResponse['sessions'] as List<dynamic>;

          // Extract session_id values
          final sessionIds = sessionsList.map((session) {
            return session['session_id'] as int;
          }).toList();

          print(
              'Session IDs: $sessionIds'); // Print or use session IDs as needed

          // Optionally, you can store these IDs or use them in your logic
          // For example, storing first session_id in sessionId
          if (sessionsList.isNotEmpty) {
            sessionId = sessionsList.first['session_id'] as int;
            print("id: $sessionId");
          }

          final sessionResponse = SessionResponse.fromJson(jsonResponse);
          allsessions = sessionResponse.sessions;
        }
        notifyListeners();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}
