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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mistakes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionImage(question.qUrl),
                const SizedBox(height: 8),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: faceBookColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              QuestionAnswerScreen(id: question.id),
                        ),
                      );
                    },
                    child: const Text(
                      'View Answer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 30,
                  thickness: 1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestionImage(String? url) {
    if (url == null || url.isEmpty) {
      return const Text(
        'No image available',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: faceBookColor,
          fontStyle: FontStyle.italic,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Text(
              'Failed to load image',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: faceBookColor,
                fontStyle: FontStyle.italic,
              ),
            );
          },
        ),
      );
    }
  }
}
