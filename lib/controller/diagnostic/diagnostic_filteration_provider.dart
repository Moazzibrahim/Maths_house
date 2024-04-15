// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DiagnosticFilterationProvider with ChangeNotifier {
  List<String> diagfilters = [];
  List<String> courseData = [];
  List<String> categoryData = [];
  List<int> courseIds = [];

  Future<void> fetchdiagdata(BuildContext context) async {
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
        print(data);

        for (var category in data['categories']) {
          categoryData.add(category['cate_name'] ?? '');
        }
        categoryData = categoryData.toSet().toList();

        for (var course in data['courses']) {
          courseData.add(course['course_name'] ?? '');
          courseIds.add(course['id'] ?? 0);
        }
        courseData = courseData.toSet().toList();

        diagfilters.addAll(categoryData);
        diagfilters.addAll(courseData);
        notifyListeners();
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
