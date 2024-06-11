import 'package:flutter/material.dart';

class ExamItem with ChangeNotifier {
  final int month;
  final String year;
  final int countOfQuestions;
  final String? section;
  final int marks;
  final int examid;
 // Make examid non-nullable

  ExamItem({
    required this.year,
    required this.month,
    required this.countOfQuestions,
    this.section,
    required this.marks,
    required this.examid,
  });

  factory ExamItem.fromJson(Map<String, dynamic> json) {
    return ExamItem(
      year: json['year'] ?? '',
      month: json['month'] ?? 0,
      countOfQuestions: (json['question'] as List).length,
      section: json['section'],
      marks: json['score'] ?? 0,
      examid: json['id'] ?? 0,
    );
  }
}

class Question with ChangeNotifier {
  int id;
  int lessonId;
  String? question;
  String state;
  String? qUrl;
  String? qCode;
  String qType;
  int month;
  String qNum;
  int year;
  String section;

  Question({
    required this.id,
    required this.lessonId,
    required this.question,
    required this.state,
    required this.qUrl,
    required this.qCode,
    required this.qType,
    required this.month,
    required this.qNum,
    required this.year,
    required this.section,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      lessonId: json['lesson_id'],
      question: json['question'],
      state: json['state'],
      qUrl: json['q_url'],
      qCode: json['q_code'],
      qType: json['q_type'],
      month: json['month'],
      qNum: json['q_num'],
      year: json['year'],
      section: json['section'],
    );
  }
}
