import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/Model/score_sheet/score_sheet_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class StudentQuizScoreProvider with ChangeNotifier {
  List<StudentQuizScore> allStudentQuizScores = [];

  Future<void> getStudentQuizScores(BuildContext context, int id) async {
    try {
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;
      final response = await http.get(
        Uri.parse('https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/lesson_score_sheet_api/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> data = responseData['data'];
        List<StudentQuizScore> scores = data.map((e) => StudentQuizScore.fromJson(e)).toList();
        allStudentQuizScores = scores;
        notifyListeners();
      } else {
        log('Error, StatusCode: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
