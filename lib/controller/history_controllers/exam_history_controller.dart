import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/history_models/exams_history_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ExamHistoryProvider with ChangeNotifier{
  List<ExamHistory> allExamHistory =[];
  List<ExamViewMistake> allmistakes = [];
  List<ExamReccomndation> allrecs = [];
  Future<void> getExamHistoryData(BuildContext context) async {
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
        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> getExamViewMistakesData(BuildContext context,int id) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam_mistakes/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        ExamViewMistakesList examMistakesList =
            ExamViewMistakesList.fromJson(responseData);
          List<ExamViewMistake> am = examMistakesList.examViewMistakeList
            .map((e) => ExamViewMistake.fromJson(e))
            .toList();
        allmistakes = am;
        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> getExamReccomendationData(BuildContext context,int id) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam_mistakes/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        ExamReccomndationList examRecList =
            ExamReccomndationList.fromJson(responseData);
          List<ExamReccomndation> er = examRecList.examReccomendationList
            .map((e) => ExamReccomndation.fromJson(e))
            .toList();
        allrecs = er;
        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}