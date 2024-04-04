// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_application_1/Model/exam_models/exam_mcq_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ExamMcqProvider with ChangeNotifier {
  Future<List<Exam>> fetchExamDataFromApi(
      BuildContext context, int examId) async {
    final url =
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam/$examId';
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> examList = jsonData['exam'];
        List<Exam> examques = [];

        for (var examData in examList) {
          final question = examData['question'];
          final List<dynamic> answers = examData['Answers'];

          final qNum = question['q_num'];
          final questionText = question['question'];
          List<Answer> mcqAnswers = [];

          for (var answer in answers) {
            final mcqAns = answer['mcq_ans'];
            mcqAnswers.add(
              Answer(
                id: answer['id'],
                mcqAns: mcqAns ?? '',
                mcqAnswers: answer['mcq_answers'],
                qId: answer['q_id'],
                createdAt: answer['created_at'],
                updatedAt: answer['updated_at'],
              ),
            );
          }

          examques.add(
            Exam(
              qNum: qNum,
              questionText: questionText,
              answers: mcqAnswers,
            ),
          );
        }
        notifyListeners();
        return examques;
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return []; // Return empty list in case of failure
  }
}
