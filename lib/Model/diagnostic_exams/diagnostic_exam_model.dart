import 'dart:convert';

import 'package:flutter/material.dart';

List<QuestionData> questionDataFromJson(String str) => List<QuestionData>.from(
    json.decode(str).map((x) => QuestionData.fromJson(x)));

String questionDataToJson(List<QuestionData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionData with ChangeNotifier {
  QuestionData({
    required this.courseId,
    required this.question,
    required this.qNum,
    required this.qType,
    required this.mcq,
    required this.gAns,
  });

  final int courseId;
  final String question;
  final String qNum;
  final String qType;
  final List<Mcq>? mcq;
  final List<dynamic>? gAns;

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      courseId: json["course_id"],
      question: json["question"],
      qNum: json["q_num"],
      qType: json["q_type"],
      mcq: json["mcq"] != null
          ? List<Mcq>.from(json["mcq"].map((x) => Mcq.fromJson(x)))
          : null,
      gAns: json["g_ans"] != null ? List<dynamic>.from(json["g_ans"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "question": question,
        "q_num": qNum,
        "q_type": qType,
        "mcq": mcq != null
            ? List<dynamic>.from(mcq!.map((x) => x.toJson()))
            : null,
        "g_ans": gAns,
      };
}

class Mcq with ChangeNotifier {
  Mcq({
    required this.id,
    this.mcqAns,
    required this.mcqAnswers,
    this.mcqnum,
    required this.qId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String? mcqAns;
  final String mcqAnswers;
  final String? mcqnum;
  final int qId;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Mcq.fromJson(Map<String, dynamic> json) => Mcq(
        id: json["id"],
        mcqAns: json["mcq_ans"],
        mcqAnswers: json["mcq_answers"],
        mcqnum: json["mcq_num"],
        qId: json["q_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mcq_ans": mcqAns,
        "mcq_answers": mcqAnswers,
        "mcq_num": mcqnum,
        "q_id": qId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
