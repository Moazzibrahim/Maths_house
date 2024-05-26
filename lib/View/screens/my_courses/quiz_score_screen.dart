import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/quizzes_model.dart';
import 'package:flutter_application_1/View/screens/history_screens/quizes_history_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class QuizScoreScreen extends StatelessWidget {
  const QuizScoreScreen({super.key, required this.quiz, required this.correctAnswers, required this.wrongAnswers});
  final QuizzesModel quiz;
  final Set<QuestionsQuiz> correctAnswers;
  final Set<int> wrongAnswers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Quiz Score'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _buildInfoRow('Quiz:', quiz.title),
            _buildInfoRow('Score:', correctAnswers.length.toString()),
            _buildInfoRow('Total Questions:', quiz.questionQuizList.length.toString()),
            _buildInfoRow('Right Answers:', correctAnswers.length.toString()),
            _buildInfoRow('Wrong Answers:', wrongAnswers.length.toString()),
            const SizedBox(height: 50,),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx)=> const QuizesHistoryScreen())
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
            )
            , child: const Text('Go to History'))
        ],
        ),
      ),
    );
  }
}


Widget _buildInfoRow(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: gridHomeColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }