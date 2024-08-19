import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/widgets/quizzes_content.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class MyLiveStartQuiz extends StatelessWidget {
  final int lessonId;

  const MyLiveStartQuiz({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Quiz screen"),
      body: QuizzesContent(lessonId: lessonId),
    );
  }
}
