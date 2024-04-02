import 'package:flutter/material.dart';

class ExamData with ChangeNotifier{
  final String courseName;
  
  final String examCode;

  ExamData({
    required this.courseName,
    
    required this.examCode,
  });

  factory ExamData.fromJson(Map<String, dynamic> json) {
    return ExamData(
      courseName: json['course_name'] ?? '',
      examCode: json['exam_code'] ?? '',
    );
  }
}
class Category with ChangeNotifier{
  final String categoryName;

  Category({required this.categoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryName: json['cate_name'] ?? '',
    );
  }
}

