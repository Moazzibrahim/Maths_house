import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/exam_models/exam_mcq_model.dart';
import 'dart:convert';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/controller/exam/start_exam_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:async';

class ExamMcqProvider with ChangeNotifier {
  Future<List<QuestionWithAnswers>> fetchExamDataFromApi(
      BuildContext context) async {
    final startExamProvider =
        Provider.of<StartExamProvider>(context, listen: false);
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    List<QuestionWithAnswers> allQuestionsWithAnswers = [];
    const int maxRetries = 5;
    const int initialDelay = 1000; // Initial delay in milliseconds

    for (var examItem in startExamProvider.examData) {
      final examId = examItem.examid;

      if (examId == null) {
        debugPrint('Exam ID is null for an exam item');
        continue;
      }

      final url =
          'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam/$examId';

      try {
        final response =
            await _fetchWithRetry(url, token!, maxRetries, initialDelay);

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);

          if (jsonData['exam'] != null &&
              jsonData['exam']['questionExam'] != null) {
            debugPrint('Exam data exists, parsing...');
            final examData = jsonData['exam']['questionExam'];
            log('Exam data: $examData');

            final question = Question.fromJson(examData['question']);
            final List<Answer> answerList = [];

            if (examData['Answers'] is List) {
              for (var answerData in examData['Answers']) {
                final answer = Answer.fromJson(answerData);
                answerList.add(answer);
                log(answer.mcqAnswers
                    .toString()); // Access mcqAnswers field here
              }
            }

            if (answerList.isNotEmpty) {
              allQuestionsWithAnswers.add(QuestionWithAnswers(
                question: question,
                answers: answerList,
                mcqOptions: answerList
                    .where((answer) => answer.mcqAns != null)
                    .map((answer) => answer.mcqAns!)
                    .toList(),
              ));
              log("all: $allQuestionsWithAnswers");
            } else {
              debugPrint('No questions found for exam ID $examId');
            }
          } else {
            debugPrint('No exam data found in the response');
          }
        } else {
          debugPrint('Failed to fetch data: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint('Error: $e');
        debugPrint('Max retries reached. Failed to fetch exam data');
      }
    }

    notifyListeners(); // Notify listeners to update the UI
    return allQuestionsWithAnswers; // Return the aggregated list of questions with answers
  }

  Future<http.Response> _fetchWithRetry(
      String url, String token, int maxRetries, int initialDelay) async {
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200 || response.statusCode != 429) {
          return response;
        }

        // Handle rate limiting
        await Future.delayed(
            Duration(milliseconds: initialDelay * (retryCount + 1)));
        retryCount++;
      } catch (e) {
        if (retryCount >= maxRetries) {
          rethrow;
        }
        await Future.delayed(
            Duration(milliseconds: initialDelay * (retryCount + 1)));
        retryCount++;
      }
    }

    throw Exception('Failed to fetch data after $maxRetries retries');
  }
}
