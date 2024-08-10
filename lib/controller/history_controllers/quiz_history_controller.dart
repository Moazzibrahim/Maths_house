import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/history_models/quizes_history_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class QuizHistoryProvider with ChangeNotifier {
List<QuizHistory> allQuizHistory=[];
List<Mistake> allMistakes = [];
Future<void> getQuizHistory(BuildContext context) async {
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
        QuizHistoryList quizHistoryList =
            QuizHistoryList.fromJson(responseData);
        List<QuizHistory> q = quizHistoryList.quizHistoryList
            .map((e) => QuizHistory.fromJson(e))
            .toList();
        allQuizHistory = q;
        notifyListeners();
      }else{
        log('error: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> getQuizMistakes(BuildContext context,int id)async{
        final tokenProvider = Provider.of<TokenModel>(context, listen: false);
        final token = tokenProvider.token;
      try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_quiz_mistakes/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        Mistakes mistakes = Mistakes.fromJson(responseData);
        List<Mistake> mistakesList = mistakes.mistakesList.map((e) => Mistake.fromJson(e),).toList();
        allMistakes = mistakesList;
        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}