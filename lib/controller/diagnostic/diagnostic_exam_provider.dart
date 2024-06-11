// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_filteration_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DiagExamProvider with ChangeNotifier {
  List<Map<String, dynamic>> alldiagnostics = [];
  int exid = 0;
  int currentIndex = 0;
  int passscore = 0;
  int score = 0;

  Future<void> fetchDataFromApi(
      BuildContext context, int selectedCourseId) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      final diagnosticFilterationProvider =
          Provider.of<DiagnosticFilterationProvider>(context, listen: false);
      await diagnosticFilterationProvider.fetchdiagdata(context);

      const int maxRetries = 5;
      int retryCount = 0;
      bool success = false;

      while (retryCount < maxRetries && !success) {
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
          final data = json.decode(response.body);
          if (data != null &&
              data['exam'] != null &&
              data['exam']['question_with_ans'] != null) {
            final List<dynamic> questions = data['exam']['question_with_ans'];
            exid = data['exam']['id'] ?? 0;
            passscore = data['exam']['pass_score'] ?? 0;
            score = data['exam']['score'] ?? 0;

            alldiagnostics.clear(); // Clear previous data
            for (var question in questions) {
              final questionMap = {
                'id': question['id'] ?? -1,
                'question': question['question'] ?? '',
                'q_num': question['q_num'] ?? '',
                'q_type': question['q_type'] ?? '',
                'q_url': question['q_url'] ?? '',
                'mcq': question['mcq'] != null
                    ? (question['mcq'] as List).map((mcq) {
                        return {
                          'mcq_num': mcq['mcq_num'] ?? "",
                          'mcq_ans': mcq['mcq_ans'] ?? '',
                          'mcq_answers': mcq['mcq_answers'] ?? '',
                        };
                      }).toList()
                    : [],
                'g_ans': question['g_ans'] ?? [],
                'selectedAnswer': null,
              };
              alldiagnostics.add(questionMap);
            }
            success = true;
            notifyListeners();
          } else {
            throw Exception('Invalid data structure: ${response.body}');
          }
        } else if (response.statusCode == 429) {
          retryCount++;
          final waitTime = Duration(seconds: 2 ^ retryCount);
          print('Retrying in ${waitTime.inSeconds} seconds...');
          await Future.delayed(waitTime);
        } else {
          throw Exception('Failed to load data: ${response.statusCode}');
        }
      }

      if (!success) {
        throw Exception('Exceeded maximum retries');
      }
    } catch (e) {
      // Log the error or show a user-friendly message
      print('Error fetching data: $e');
    }
  }

  void selectAnswer(String? answer) {
    alldiagnostics[currentIndex]['selectedAnswer'] = answer;
    notifyListeners();
  }

  void goToNextQuestion() {
    if (currentIndex < alldiagnostics.length - 1) {
      currentIndex++;
      notifyListeners();
    }
  }

  void goToPreviousQuestion() {
    if (currentIndex > 0) {
      currentIndex--;
      notifyListeners();
    }
  }

  int getUnansweredQuestionIndex() {
    for (int i = 0; i < alldiagnostics.length; i++) {
      if (alldiagnostics[i]['selectedAnswer'] == null) {
        return i;
      }
    }
    return -1; // All questions answered
  }

  void navigateToQuestion(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
