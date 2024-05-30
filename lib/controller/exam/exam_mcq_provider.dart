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
  Future<List<QuestionWithAnswers>> fetchExamDataFromApi(BuildContext context) async {
    final startExamProvider = Provider.of<StartExamProvider>(context, listen: false);
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    List<QuestionWithAnswers> allQuestionsWithAnswers = [];

    for (var examItem in startExamProvider.examData) {
      final examId = examItem.examid;

      if (examId == null) {
        debugPrint('Exam ID is null for an exam item');
        continue;
      }

      final url = 'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam/$examId';

      int retryCount = 0;
      const int maxRetries = 5;
      const int initialDelay = 1000; // Initial delay in milliseconds

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

          if (response.statusCode == 200) {
            final jsonData = json.decode(response.body);
            final List<QuestionWithAnswers> questionsWithAnswers = [];
            // Check if the exam and questionExam fields are present
            if (jsonData['exam'] != null && jsonData['exam']['questionExam'] != null) {
              debugPrint('Exam data exists, parsing...');
              final examData = jsonData['exam']['questionExam'];
              log('Exam data: $examData');
              final question = Question.fromJson(examData['question']);
              final List<Answer> answerList = [];

              // Loop through the answers
              if (examData['Answers'] != null) {
                for (var answerData in examData['Answers']) {
                  final answer = Answer.fromJson(answerData);
                  answerList.add(answer);
                  log(answer.mcqAnswers.toString()); // Access mcqAnswers field here
                }
              }

              // Create a QuestionWithAnswers object and add it to the list
              questionsWithAnswers.add(QuestionWithAnswers(
                question: question,
                answers: answerList,
                mcqOptions: answerList
                    // Ensure mcqAns is not null before adding to the list
                    // ignore: unnecessary_null_comparison
                    .where((answer) => answer.mcqAns != null)
                    .map((answer) => answer.mcqAns)
                    .toList(),
              ));
              log("all: $questionsWithAnswers");
            } else {
              debugPrint('No exam data found in the response');
            }

            allQuestionsWithAnswers.addAll(questionsWithAnswers);
            break; // Exit the retry loop on successful response
          } else if (response.statusCode == 429) {
            // Handle rate limiting
            debugPrint('Rate limit exceeded. Retrying...');
            await Future.delayed(Duration(milliseconds: initialDelay * (retryCount + 1)));
            retryCount++;
          } else {
            debugPrint('Failed to fetch data: ${response.statusCode}');
            // Handle specific status codes if needed
            break; // Exit the retry loop on other status codes
          }
        } catch (e) {
          debugPrint('Error: $e');
          if (retryCount < maxRetries) {
            debugPrint('Retrying...');
            await Future.delayed(Duration(milliseconds: initialDelay * (retryCount + 1)));
            retryCount++;
          } else {
            debugPrint('Max retries reached. Failed to fetch exam data');
            break; // Exit the retry loop if max retries reached
          }
        }
      }
    }

    return allQuestionsWithAnswers; // Return the aggregated list of questions with answers
  }
}
