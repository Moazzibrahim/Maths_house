import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/history_models/questions_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class QuestionHistoryProvider with ChangeNotifier {
  List<QuestionHistory> allQuestionsHistory = [];
  Future<void> getQuestionsHistoryData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_chapters'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        QuestionsHistoryList questionsHistoryList =
            QuestionsHistoryList.fromJson(responseData);
        List<QuestionHistory> q = questionsHistoryList.questionsHistoryList
            .map((e) => QuestionHistory.fromJson(e))
            .toList();
        allQuestionsHistory = q;
        log('allqh:$allQuestionsHistory');
        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
