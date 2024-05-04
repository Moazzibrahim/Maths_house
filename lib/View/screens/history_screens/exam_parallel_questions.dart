import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class ExamParallelQuestion extends StatelessWidget {
  const ExamParallelQuestion({super.key, required this.questionId});
  final int questionId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Solve parallel'),
    );
  }
}