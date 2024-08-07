import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/score_sheet/score_sheet_model.dart';
import 'package:flutter_application_1/View/screens/history_screens/question_answer_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';

class MistakesScreen extends StatelessWidget {
  final List<Question> questions;

  const MistakesScreen({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mistakes'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.qUrl ?? 'No URL available',
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: faceBookColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuestionAnswerScreen(id: question.id)),
                  );
                },
                child: const Text(
                  'View Answer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Divider(color: Colors.grey, height: 30),
            ],
          );
        },
      ),
    );
  }
}
