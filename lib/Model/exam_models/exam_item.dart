import 'package:flutter/material.dart';

class ExamItem with ChangeNotifier {
  int id;
  String title;
  String description;
  String time;
  int score;
  int passScore;
  String year;
  int? month;
  List<Question> questions;
  

  ExamItem({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.score,
    required this.passScore,
    required this.year,
    required this.month,
    required this.questions,
  });

  factory ExamItem.fromJson(Map<String, dynamic> json) {
    return ExamItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      time: json['time'],
      score: json['score'],
      passScore: json['pass_score'],
      year: json['year'],
      month: json['month'],
      questions: (json['question'] as List)
          .map((question) => Question.fromJson(question))
          .toList(),
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
