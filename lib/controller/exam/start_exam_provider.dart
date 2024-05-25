// ignore_for_file: avoid_print, use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/exam_models/exam_item.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StartExamProvider with ChangeNotifier {
  Set<ExamItem> examData = {};
  int? examId;

  Future<List<ExamItem>> fetchDataFromApi(
      BuildContext context, Map<String, dynamic> my) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    const maxRetries = 3;
    var attempt = 0;

    while (attempt < maxRetries) {
      try {
        // Fetch the exam ID first
        examId ??= await fetchExamId(context);

        final response = await http.post(
            Uri.parse(
              'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_filter_exam_process',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(my));
        print("post map: $my");

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          print("exams=: $jsonData");
          final dynamic examList = jsonData['exam_items'];

          // Process exam items
          Set<ExamItem> examItemList = {};
          Set<Question> questionlist = {};
          for (var examData in examList) {
            final List<dynamic> questions = examData['question'];
            final int month = examData['month'] ?? 0;
            final String year = examData['year'] ?? '';
            final int marks = examData['score'] ?? 0;
            final int countOfQuestions = questions.length;
            examItemList.add(
              ExamItem(
                month: month,
                year: year,
                countOfQuestions: countOfQuestions,
                marks: marks,
                examid: examId,
              ),
            );

            // You need to loop through each question in the 'question' list
            for (var questionData in questions) {
              final String sectionid = questionData['section'];
              final String question = questionData['question'];

              // Other properties of the exam item
              // Create ExamItem object and add to list
            }
          }
          examData = examItemList.toSet();
          notifyListeners();
        } else if (response.statusCode == 429) {
          // Exponential backoff with random delay between attempts
          final delay = (2 ^ attempt) * 1000 + Random().nextInt(1001);
          print('Retrying after $delay milliseconds');
          await Future.delayed(Duration(milliseconds: delay));
        } else {
          throw Exception(
              'Failed to load data from API: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching data (attempt $attempt): $e');
        rethrow; // Rethrow the caught error
      }
      attempt++;
    }

    throw Exception('Failed to load data after $maxRetries attempts');
  }

  Future<int> fetchExamId(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      final response = await http.get(
        Uri.parse(
          'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_filter_exam_process',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> examItems = jsonData['exam_items'];

        // Assuming we want to get the first exam ID in the response
        if (examItems.isNotEmpty) {
          examId = examItems[0]['id'];
          print("exam id is : $examId");
          return examId!;
        } else {
          throw Exception('No exam items found.');
        }
      } else {
        throw Exception('Failed to fetch exam ID: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching exam ID: $e');
      rethrow; // Rethrow the caught error
    }
  }
}
