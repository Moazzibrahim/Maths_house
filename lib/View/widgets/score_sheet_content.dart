import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/score_sheet/score_sheet_model.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ScoreSheetContent extends StatelessWidget {
  final ScoreData scoreData;
  final int? lessid;

  const ScoreSheetContent({super.key, required this.scoreData, this.lessid});

  @override
  Widget build(BuildContext context) {
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
                const Icon(Icons.quiz, size: 30, color: faceBookColor),
                const SizedBox(width: 10),
                Text(
                  scoreData.quizName,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(color: Colors.grey, height: 30),
            buildScoreRow(Icons.score, 'Score', '${scoreData.score}'),
            const SizedBox(height: 10),
            buildScoreRow(Icons.access_time, 'Time', scoreData.time),
            const SizedBox(height: 10),
            buildScoreRow(Icons.calendar_today, 'Date', scoreData.date),
            const SizedBox(height: 10),
            buildScoreRow(
                Icons.error_outline, 'Mistakes', '${scoreData.mistakes}'),
          ],
        ),
      ),
    );
  }

  Widget buildScoreRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 25, color: Colors.grey),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
