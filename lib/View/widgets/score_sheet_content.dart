import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/score_sheet/score_sheet_model.dart';
import 'package:flutter_application_1/View/screens/mistakes_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/student_quiz_score_provider.dart';
import 'package:provider/provider.dart';

class ScoreSheetContent extends StatelessWidget {
  final int lessonId;

  const ScoreSheetContent({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<StudentQuizScoreProvider>(context, listen: false)
          .getStudentQuizScores(context, lessonId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data.'));
        } else {
          return Consumer<StudentQuizScoreProvider>(
            builder: (context, quizzesProvider, _) {
              if (quizzesProvider.allStudentQuizScores.isEmpty) {
                return const Center(child: Text('No data available.'));
              } else {
                return ListView.builder(
                  itemCount: quizzesProvider.allStudentQuizScores.length,
                  itemBuilder: (context, index) {
                    final score = quizzesProvider.allStudentQuizScores[index];
                    return Card(
                      margin: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.quiz,
                                    size: 30, color: faceBookColor),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    score.quizze.title,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.grey, height: 30),
                            buildScoreRow(
                              Icons.score,
                              'Score',
                              score.score.toString(),
                            ),
                            buildScoreRow(
                              Icons.access_time,
                              'Time',
                              score.time ?? 'Null',
                            ),
                            buildScoreRow(
                              Icons.calendar_today,
                              'Date',
                              score.date.toLocal().toString().split(' ')[0],
                            ),
                            buildMistakesRow(
                              context,
                              Icons.error_outline,
                              'Mistakes',
                              score
                                  .questions, // Pass the list of questions here
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        }
      },
    );
  }

  Widget buildScoreRow(IconData icon, String label, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      leading: Icon(icon, size: 25, color: Colors.grey),
      title: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: Text(
        value,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget buildMistakesRow(BuildContext context, IconData icon, String label,
      List<Question> questions) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      leading: Icon(icon, size: 25, color: Colors.grey),
      title: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: faceBookColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MistakesScreen(
                questions: questions,
              ),
            ),
          );
        },
        child: const Text(
          'View Mistakes',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
