// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ExamProvider with ChangeNotifier {
  List<String> courseData = [];
  List<String> categoryData = [];
  List<String> examCodeData = [];
  List<String> allexamsfilters = [];

  Future<void> fetchData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam_filter'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        // Parse courses
        // Parse courses
        for (var course in data['courses']) {
          courseData.add(course['course_name'] ?? '');
        }
        courseData = courseData.toSet().toList(); // Remove duplicates

// Parse categories
        for (var category in data['categories']) {
          categoryData.add(category['cate_name'] ?? '');
        }
        categoryData = categoryData.toSet().toList(); // Remove duplicates

// Parse exam codes
        for (var code in data['codes']) {
          examCodeData.add(code['exam_code'] ?? '');
        }
        examCodeData = examCodeData.toSet().toList(); // Remove duplicates

        // Combine all data into allexamsfilters
        allexamsfilters.addAll(courseData);
        allexamsfilters.addAll(categoryData);
        allexamsfilters.addAll(examCodeData);

        notifyListeners();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
