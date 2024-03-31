import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/widgets/start_exam_widget.dart';

class ExamScreenstart extends StatelessWidget {
  const ExamScreenstart({Key? key}) : super(key: key);

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
