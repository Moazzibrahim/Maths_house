// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ExamProvider with ChangeNotifier {
  List<int> courseIds = [];
  List<String> courseNames = [];
  
  List<int> categoryIds = [];
  List<String> categoryNames = [];
  
  List<int> examCodeIds = [];
  List<String> examCodes = [];

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

        List<int> newCourseIds = [];
        List<String> newCourseNames = [];

        List<int> newCategoryIds = [];
        List<String> newCategoryNames = [];

        List<int> newExamCodeIds = [];
        List<String> newExamCodes = [];

        // Parse courses
        for (var course in data['courses']) {
          if (course['id'] != null && course['course_name'] != null) {
            newCourseIds.add(course['id']);
            newCourseNames.add(course['course_name']);
          }
        }

        // Parse categories
        for (var category in data['categories']) {
          if (category['id'] != null && category['cate_name'] != null) {
            newCategoryIds.add(category['id']);
            newCategoryNames.add(category['cate_name']);
          }
        }

        // Parse exam codes
        for (var code in data['codes']) {
          if (code['id'] != null && code['exam_code'] != null) {
            newExamCodeIds.add(code['id']);
            newExamCodes.add(code['exam_code']);
          }
        }

        // Remove duplicates
        courseIds = newCourseIds.toSet().toList();
        courseNames = newCourseNames.toSet().toList();

        categoryIds = newCategoryIds.toSet().toList();
        categoryNames = newCategoryNames.toSet().toList();

        examCodeIds = newExamCodeIds.toSet().toList();
        examCodes = newExamCodes.toSet().toList();

        // Combine all data into allexamsfilters for any combined usage
        allexamsfilters = [];
        allexamsfilters.addAll(courseNames);
        allexamsfilters.addAll(categoryNames);
        allexamsfilters.addAll(examCodes);

        notifyListeners();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      print('ClientException: $e');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
