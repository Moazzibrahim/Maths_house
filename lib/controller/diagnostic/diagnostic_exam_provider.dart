// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/diagnostic_exams/diagnostic_exam_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_filteration_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DiagExamProvider with ChangeNotifier {
  String? _selectedCourse;
  Future<List<QuestionData>?> fetchDataFromApi(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    final selectedCourseId = Provider.of<DiagnosticFilterationProvider>(context,
            listen: false)
        .courseIds
        .firstWhere((courseId) =>
            _selectedCourse ==
            Provider.of<DiagnosticFilterationProvider>(context, listen: false)
                .courseData[courseId - 1]);
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_dia_exam/$selectedCourseId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<QuestionData> questions =
            questionDataFromJson(jsonResponse["exam"]["question_with_ans"]);

        // Access properties of each question and perform desired operations
        for (var question in questions) {
          var questionName = question.question; // Access question name
          var questionType = question.qType; // Access question type
          var questionNum = question.qNum; // Access question number
          var mcqList = question.mcq; // Access MCQ list
          var generalAnswerList = question.gAns; // Access general answer list

          // Perform operations with the accessed properties as needed
          print('Question Name: $questionName');
          print('Question Type: $questionType');
          print('Question Number: $questionNum');
          print('MCQ List: $mcqList');
          print('General Answer List: $generalAnswerList');
        }

        return questions;
      } else {
        // If the request fails, throw an exception or handle the error accordingly
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      throw Exception('Error fetching data: $e');
    }
  }
}
