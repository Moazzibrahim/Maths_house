import 'package:flutter/material.dart';

class Exam with ChangeNotifier {
  final String qNum;
  final String questionText;
  final List<Answer> answers;

  Exam({
    required this.qNum,
    required this.questionText,
    required this.answers,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      qNum: json['question']['q_num'],
      questionText: json['question']['questionText'],
      answers: List<Answer>.from(json['Answers'].map((x) => Answer.fromJson(x))),
    );
  }
}

class Answer with ChangeNotifier {
  final int id;
  final String mcqAns;
  final String mcqAnswers;
  final int qId;
  final String createdAt;
  final String updatedAt;

  Answer({
    required this.id,
    required this.mcqAns,
    required this.mcqAnswers,
    required this.qId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      mcqAns: json['mcq_ans'] ?? '',
      mcqAnswers: json['mcq_answers'],
      qId: json['q_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
