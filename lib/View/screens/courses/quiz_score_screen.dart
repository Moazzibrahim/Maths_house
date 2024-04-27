import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class QuizScoreScreen extends StatelessWidget {
  const QuizScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Quiz Score'),
    );
  }
}