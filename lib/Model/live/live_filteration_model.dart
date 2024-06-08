import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/diagnostic_exams/diagnostic_filteration.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// Import your DiagnosticCourse model

class LiveFilterationProvider with ChangeNotifier {
  List<DiagnosticCategory> categoryData = [];
  List<DiagnosticCourse> courseData = [];
  bool _mustBuyNewPackage = false;

  bool get mustBuyNewPackage => _mustBuyNewPackage;

  Future<void> fetchDiagData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_dia_exam_filter'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<DiagnosticCategory> categories = [];
        List<DiagnosticCourse> courses = [];
        for (var category in data['categories']) {
          categories.add(DiagnosticCategory.fromJson(category));
        }
        for (var course in data['courses']) {
          courses.add(DiagnosticCourse.fromJson(course));
        }
        categoryData = categories.toSet().toList();
        courseData = courses.toSet().toList();

        // Example logic to determine if a new package must be bought
        _mustBuyNewPackage = data['must_buy_new_package'] ?? false;

        notifyListeners();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
