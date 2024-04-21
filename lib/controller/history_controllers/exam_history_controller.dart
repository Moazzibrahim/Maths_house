import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/history_models/exams_history_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ExamHistoryProvider with ChangeNotifier{
  List<ExamHistory>allExamHistory =[];
  Future<void> getQuestionsHistoryData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_history'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        ExamHistoryList examHistoryList =
            ExamHistoryList.fromJson(responseData);
        List<ExamHistory> q = examHistoryList.examHistoryList
            .map((e) => ExamHistory.fromJson(e))
            .toList();
        allExamHistory = q;
        // log('allquestionHistory ids: ${allExamHistory.map((e) => e.id)}');
        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}