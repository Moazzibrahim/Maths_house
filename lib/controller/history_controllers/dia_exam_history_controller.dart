import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/history_models/dia_exam_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DiaExamHistoryProvider with ChangeNotifier {
  List<DiaExamHistory> allDiaExam=[]; 
  Future<void> getDiaExamHistory(BuildContext context) async {
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
        DiaExamHistoryList diaexamHistoryList =
            DiaExamHistoryList.fromJson(responseData);
        List<DiaExamHistory> d = diaexamHistoryList.diaExamList
            .map((e) => DiaExamHistory.fromJson(e))
            .toList();
        allDiaExam = d;
        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}