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
  List<int> examIds = [];

  Future<List<ExamItem>> fetchDataFromApi(
      BuildContext context, Map<String, dynamic> my) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    const maxRetries = 3;
    var attempt = 0;

    while (attempt < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse(
              'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_filter_exam_process'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(my),
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final dynamic examList = jsonData['exam_items'];

          Set<ExamItem> examItemList = {};
          for (var examData in examList) {
            final examId = examData['id'];
            examIds.add(examId);
            print("list ids: $examIds");
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
          }
          examData = examItemList.toSet();

          notifyListeners();
          return examItemList.toList();
        } else if (response.statusCode == 429) {
          final delay = (2 ^ attempt) * 1000 + Random().nextInt(1001);
          await Future.delayed(Duration(milliseconds: delay));
        } else {
          throw Exception(
              'Failed to load data from API: ${response.statusCode}');
        }
      } catch (e) {
        rethrow;
      }
      attempt++;
    }

    throw Exception('Failed to load data after $maxRetries attempts');
  }
}
