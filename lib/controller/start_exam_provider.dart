// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/exam_models/exam_item.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StartExamProvider with ChangeNotifier {
  List<ExamItem> examData = [];

  Future<List<ExamItem>> fetchDataFromApi(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    const maxRetries = 3;
    var attempt = 0;

    while (attempt < maxRetries) {
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

          // Process exam items
          List<ExamItem> examItemList = [];
          for (var examItem in examItems) {
            final List<dynamic> questions = examItem['question'];
            final int countOfQuestions = questions.length;

            // Extract sections from questions
            List<String> sections = [];
            for (var question in questions) {
              sections.add(question['section'] ?? '');
            }

            // Other properties of the exam item
            final int month = examItem['month'] ?? 0;
            final String year = examItem['year'] ?? '';
            final int marks = examItem['score'] ?? 0;
            final int examid = examItem['id'] ?? 0;

            // Create ExamItem object and add to list
            examItemList.add(
              ExamItem(
                month: month,
                year: year,
                countOfQuestions: countOfQuestions,
                section: sections
                    .join(','), // Concatenate sections into a single string
                marks: marks,
                examid: examid,
              ),
            );
          }
          examData = examItemList;
          notifyListeners();
          return examItemList;
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
}
