import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/history_models/questions_answers_model.dart';
import 'package:flutter_application_1/Model/history_models/questions_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class QuestionHistoryProvider with ChangeNotifier {
  List<QuestionHistory> allQuestionsHistory = [];
  List<QuestionAnswer> allQuestionAnswers = [];
  List<Parallel> allParallelQuestions=[];
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
        QuestionsHistoryList questionsHistoryList =
            QuestionsHistoryList.fromJson(responseData);
        List<QuestionHistory> q = questionsHistoryList.questionsHistoryList
            .map((e) => QuestionHistory.fromJson(e))
            .toList();
        allQuestionsHistory = q;
        log('allquestionHistory ids: ${allQuestionsHistory.map((e) => e.id)}');
        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> getQuestionAnswer(BuildContext context,int id) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_question_mistake/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        QuestionAnswerList questionAnswerList =
            QuestionAnswerList.fromJson(responseData);
        List<QuestionAnswer> q = questionAnswerList.questionAnswerList
            .map((e) => QuestionAnswer.fromJson(e))
            .toList();
        allQuestionAnswers = q;
        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> getParallelQuestion(BuildContext context,int id) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_question_mistake/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        ParallelList parallelList =
            ParallelList.fromJson(responseData);
        List<Parallel> p = parallelList.parallelList
            .map((e) => Parallel.fromJson(e))
            .toList();
        allParallelQuestions = p;
        log('all pppppppppp: $allParallelQuestions');
        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
