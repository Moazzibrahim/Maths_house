
import 'package:flutter/material.dart';

class Exam  with ChangeNotifier{
  String category;
  String course;
  String year;
  String month;
  String examCode;

  Exam({
    required this.category,
    required this.course,
    required this.year,
    required this.month,
    required this.examCode,
  });
}
