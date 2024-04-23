import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/View/screens/history_screens/dia_exam_history_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/exam_history_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/question_history_screen.dart';
import 'package:flutter_application_1/View/widgets/unregistered_courses_custom.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'History'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          GestureDetector(onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx)=> const QuestionHistoryScreen())
            );
          },child: const CustomUnregisteredWidgets(text: 'Questions')),
          GestureDetector(onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx)=> const ExamHistoryScreen())
            );
          },child: const CustomUnregisteredWidgets(text: 'Exams')),
          GestureDetector(onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx)=> const DiaExamHistoryScreen())
            );
          },child: const CustomUnregisteredWidgets(text: 'Diagnostic Exams')),
          const CustomUnregisteredWidgets(text: 'Quizes'),
        ]),
      ),
    );
  }
}