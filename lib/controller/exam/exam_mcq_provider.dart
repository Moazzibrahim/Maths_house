// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/exam_models/exam_mcq_model.dart';
import 'dart:convert';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/controller/exam/start_exam_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ExamMcqProvider with ChangeNotifier {
  Future<List<QuestionWithAnswers>> fetchExamDataFromApi(
      BuildContext context) async {
    final startExamProvider =
        Provider.of<StartExamProvider>(context, listen: false);
    final examId = startExamProvider.examId;

    if (examId == null) {
      debugPrint('Exam ID is null');
      return [];
    }

    final url =
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam/16';
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

        debugPrint('Response data: ${jsonData['exam']}');

        // Check if the exam and questionExam fields are present
        if (jsonData['exam'] != null &&
            jsonData['exam']['questionExam'] != null) {
          debugPrint('Exam data exists, parsing...');
          final examData = jsonData['exam']['questionExam'];

          log('Exam data: $examData');
          log('Type of examData: ${examData.runtimeType}');

          final question = Question.fromJson(examData['question']);
          log('Question: $question');

          final List<Answer> answerList = [];

          // Loop through the answers
          if (examData['Answers'] != null) {
            for (var answerData in examData['Answers']) {
              final answer = Answer.fromJson(answerData);
              answerList.add(answer);
              log("answer list: $answerList");
              log(answer.mcqAnswers.toString()); // Access mcqAnswers field here
            }
          }

          // Create a QuestionWithAnswers object and add it to the list
          questionsWithAnswers.add(QuestionWithAnswers(
            question: question,
            answers: answerList,
            mcqOptions: answerList
                // Ensure mcqAns is not null before adding to the list
                .where((answer) => answer.mcqAns != null)
                .map((answer) => answer.mcqAns)
                .toList(),
          ));
          log("all: $questionsWithAnswers");
        } else {
          debugPrint('No exam data found in the response');
        }

        return questionsWithAnswers;
      } else {
        debugPrint('Failed to fetch data: ${response.statusCode}');
        // Handle specific status codes if needed
      }
    } catch (e) {
      debugPrint('Error: $e');
      // Optionally, handle specific exceptions if needed
    }

    return []; // Return an empty list in case of failure
  }
}
