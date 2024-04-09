import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/live_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
// Import your model classes

class LiveProvider extends ChangeNotifier {
  List<Session> allsessions = [];
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
        // ignore: avoid_print
        print(jsonResponse); // Log the API response
        final sessionResponse = SessionResponse.fromJson(jsonResponse);
        allsessions = sessionResponse.sessions;
        notifyListeners();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}
