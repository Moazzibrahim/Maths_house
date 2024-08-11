import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/exam_code_question_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ExamCodeProvider with ChangeNotifier {
  List<ExamCode> examCodes = [];
  String? selectedExamCode;
  int? selectedExamCodeId;

  Future<void> fetchExamCodes(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_q_code'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        ExamCodeList examCodeList =
            ExamCodeList.fromJson(responseData['codes']);
        examCodes = examCodeList.codes;
        notifyListeners();
      } else {
        throw Exception('Failed to load exam codes');
      }
    } catch (e) {
      log('Error fetching exam codes: $e');
    }
  }

  void selectExamCode(String examCode, int examCodeId) {
    selectedExamCode = examCode;
    selectedExamCodeId = examCodeId;
    notifyListeners();
  }
}
