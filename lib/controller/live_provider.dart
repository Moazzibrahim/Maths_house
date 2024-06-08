import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/live/live_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LiveProvider extends ChangeNotifier {
  List<Session> allsessions = [];
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
        print(response.body);
        print(jsonResponse); // Log the API response
        if (jsonResponse['message'] == 'Sorry: You Must Buy New Package') {
          mustBuyNewPackage = true;
          allsessions = [];
        } else {
          print(response.body);

          mustBuyNewPackage = false;
          final sessionResponse = SessionResponse.fromJson(jsonResponse);
          allsessions = sessionResponse.sessions;
        }
        notifyListeners();
        print(response.body);
      } else {
        print(response.body);
        throw Exception('Failed to load courses');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}
