import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/widgets/start_exam_widget.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ExamScreenstart extends StatelessWidget {
  const ExamScreenstart({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated list of exams
    List<String> exams = [
      'Exam 1',
      'Exam 2',
      'Exam 3',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exams'),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: faceBookColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          return ExamGridItem(
            examName: exams[index],
          );
        },
      ),
    );
  }
}
