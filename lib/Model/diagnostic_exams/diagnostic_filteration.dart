import 'package:flutter/material.dart';

class DiagnosticCategory with ChangeNotifier {
  final String categoryName;

  DiagnosticCategory({required this.categoryName});

  factory DiagnosticCategory.fromJson(Map<String, dynamic> json) {
    return DiagnosticCategory(
      categoryName: json['cate_name'],
    );
  }
}

class DiagnosticCourse with ChangeNotifier {
  final String courseName;

  DiagnosticCourse({required this.courseName});

  factory DiagnosticCourse.fromJson(Map<String, dynamic> json) {
    return DiagnosticCourse(
      courseName: json['course_name'],
    );
  }
}
