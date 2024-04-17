// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_filteration_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DiagExamProvider with ChangeNotifier {
  List<Map<String, dynamic>> alldiagnostics = [];

  Future<void> fetchDataFromApi(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      final diagnosticFilterationProvider =
          Provider.of<DiagnosticFilterationProvider>(context, listen: false);
      await diagnosticFilterationProvider.fetchdiagdata(context);

      final selectedCourseId = diagnosticFilterationProvider.courseIds.first;

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
        print(data);

        if (data['exam'] != null && data['exam']['question_with_ans'] != null) {
          for (var exam in data['exam']['question_with_ans']) {
            // Create a map representing a question
            final questionMap = {
              'question': exam['question'],
              'question_num': exam['q_num'],
              'q_type': exam['q_type'],
              'ans_type': exam['ans_type'],
            };

            // Add the question map to the list
            alldiagnostics.add(questionMap);

            // If the question has multiple-choice answers, add them to the list
            if (exam['mcq'] != null) {
              for (var mcq in exam['mcq']) {
                final mcqMap = {
                  'mcq_ans': mcq['mcq_ans'],
                  'mcq_answers': mcq['mcq_answers'],
                };
                alldiagnostics.add(mcqMap);
              }
            }

            // If the question has grid-type answers, add them to the list
            if (exam['g_ans'] != null) {
              for (var gAns in exam['g_ans']) {
                final gAnsMap = {'grid_ans': gAns['grid_ans']};
                alldiagnostics.add(gAnsMap);
              }
            }
          }
        }

        // Notify listeners that the data has been updated
        notifyListeners();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
