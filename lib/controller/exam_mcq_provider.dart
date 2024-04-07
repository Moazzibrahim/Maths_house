import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/exam_models/exam_mcq_model.dart';
import 'dart:convert';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/controller/start_exam_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ExamMcqProvider with ChangeNotifier {
  Future<List<QuestionWithAnswers>> fetchExamDataFromApi(
      BuildContext context) async {
    final startExamProvider =
        Provider.of<StartExamProvider>(context, listen: false);
    final examId = startExamProvider.examId;

    if (examId == null) {
      print('Exam ID is null');
      return [];
    }

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
        final List<QuestionWithAnswers> questionsWithAnswers = [];

        // Loop through the exam data
        if (jsonData['exam'] != null) {
          for (var examData in jsonData['exam']) {
            final Question question = Question.fromJson(examData['question']);
            final List<Answer> answerList = [];

            // Loop through the answers
            if (examData['Answers'] != null) {
              for (var answerData in examData['Answers']) {
                final Answer answer = Answer.fromJson(answerData);
                answerList.add(answer);
              }
            }

            // Create a QuestionWithAnswers object and add it to the list
            questionsWithAnswers.add(QuestionWithAnswers(
              question: question,
              answers: answerList,
              mcqOptions: answerList
                  .where((answer) => answer.mcqAns != null)
                  .map((answer) => answer.mcqAns!)
                  .toList(),
            ));
          }
        }

        return questionsWithAnswers;
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return []; // Return empty list in case of failure
  }
}

class QuestionWithAnswers {
  final Question question;
  final List<Answer> answers;
  final List<String> mcqOptions;

  QuestionWithAnswers({
    required this.question,
    required this.answers,
    required this.mcqOptions,
  });
}