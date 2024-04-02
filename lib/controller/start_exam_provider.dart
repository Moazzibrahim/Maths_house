// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StartExamProvider with ChangeNotifier {
  List<Map<String, dynamic>> examData = [];

  List<String> years = [];
  List<int> months = [];
  List<int> scores = [];
  List<int> questionCounts = [];
  List<List<String>> sections = [];

  Future<void> getExamData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      final response = await http.post(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_filter_exam_process'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'key': 'value',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> examItems = responseData['exam_items'];

        for (var examItem in examItems) {
          String year = examItem['year'];
          int? month = examItem['month'];
          int actualMonth = month ?? 0;
          int score = examItem['score'];
          List<dynamic> questions = examItem['question'];
          int questionCount = questions.length;
          List<String> sectionList = questions
              .map((question) => question['section'].toString())
              .toList();

          years.add(year);
          months.add(actualMonth);
          scores.add(score);
          questionCounts.add(questionCount);
          sections.add(sectionList);

          examData.add({
            'year': year,
            'month': actualMonth,
            'score': score,
            'questionCount': questionCount,
            'sections': sectionList,
          });
        }

        notifyListeners();
      } else {
        print('Failed to load exam data: ${response.statusCode}');
        // Handle error (e.g., show snackbar or dialog)
      }
    } catch (e) {
      print('Error: $e');
      // Handle error (e.g., show snackbar or dialog)
    }
  }
}
