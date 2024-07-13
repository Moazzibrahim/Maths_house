import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/quiz_history_controller.dart';
import 'package:provider/provider.dart';

class QuizMistakesScreen extends StatelessWidget {
  const QuizMistakesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Mistakes'),
      body: Consumer<QuizHistoryProvider>(
        builder: (context, mistakeProvider, _) {
          final mistakes = mistakeProvider.allMistakes;
          if(mistakes.isEmpty){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            return ListView.builder(
              itemCount: mistakes.length,
              itemBuilder: (context, index) {
                return Text(mistakes[index].qurl);
              },
              );
          }
        },
      ),
    );
  }
}