import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/history_screens/question_history_screen.dart';
import 'package:flutter_application_1/View/widgets/unregistered_courses_custom.dart';
import 'package:flutter_application_1/constants/colors.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: gridHomeColor, borderRadius: BorderRadius.circular(12)),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.redAccent[700],
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          GestureDetector(onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx)=> const QuestionHistoryScreen())
            );
          },child: const CustomUnregisteredWidgets(text: 'Questions')),
          const CustomUnregisteredWidgets(text: 'Exams'),
          const CustomUnregisteredWidgets(text: 'Diagnostic Exams'),
        ]),
      ),
    );
  }
}