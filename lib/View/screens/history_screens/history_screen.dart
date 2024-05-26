import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/history_screens/dia_exam_history_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/exam_history_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/payment_history.dart';
import 'package:flutter_application_1/View/screens/history_screens/question_history_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/quizes_history_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'History'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const QuestionHistoryScreen()));
              },
              child: const HistoryContainer(text: 'Questions')),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const ExamHistoryScreen()));
              },
              child: const HistoryContainer(text: 'Exams')),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const DiaExamHistoryScreen()));
              },
              child: const HistoryContainer(text: 'Diagnostic Exams')),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const QuizesHistoryScreen()));
              },
              child: const HistoryContainer(text: 'Quizes')),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const Paymenthistoryscreen()));
              },
              child: const HistoryContainer(text: 'payment')),
        ]),
      ),
    );
  }
}

class HistoryContainer extends StatelessWidget {
  const HistoryContainer({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(
        horizontal: 7.w,
        vertical: 15.h,
      ),
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: gridHomeColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent[700],
                  fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}