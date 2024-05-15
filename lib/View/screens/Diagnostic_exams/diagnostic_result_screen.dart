// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/View/screens/registered_home_screen.dart';
import 'package:flutter_application_1/controller/diagnostic/get_course_provider.dart';
import 'package:provider/provider.dart';

class DiagnosticResultScreen extends StatefulWidget {
  final int? wrongCount;
  final int correctCount;
  final int? totalQuestions;
  final int? passscore;
  final int seconds;
  final List<int> wrongQuestionIds;
  final int? score;
  final int exid;

  const DiagnosticResultScreen({
    super.key,
    this.wrongCount,
    required this.correctCount,
    this.totalQuestions,
    this.passscore,
    required this.seconds,
    this.score,
    required this.exid,
    required this.wrongQuestionIds,
  });

  @override
  State<DiagnosticResultScreen> createState() => _DiagnosticResultScreenState();
}

class _DiagnosticResultScreenState extends State<DiagnosticResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetCourseProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<Map<String, dynamic>>(
          future: provider.fetchDataFromApi({
            'timer': widget.seconds, // Change this to the appropriate value
            'r_question': widget.correctCount,
            'exam_id': widget.exid,
            'mistakes':
                '[${widget.wrongQuestionIds.join(',')}]', // Change this to the appropriate value
          }, context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              int? grade = snapshot.data!['score'] as int?;
              String chapterName = snapshot.data!['recommandition'] != null
                  ? snapshot.data!['recommandition'][0]['chapter_name'] ?? ''
                  : '';
              return _buildResultScreen(context, grade, chapterName);
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        );
      },
    );
  }

  Widget _buildResultScreen(
      BuildContext context, int? grade, String chapterName) {
    bool showRecommendation = false;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Result",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: faceBookColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisteredHomeScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoRow("total score", "${widget.score}"),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow(
                "grade", "${grade}"), // Change this to the appropriate value
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Total Questions", " ${widget.totalQuestions}"),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Correct Questions", "${widget.correctCount}"),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Wrong Questions", "${widget.wrongCount}"),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
              onPressed: () {
                setState(() {
                  showRecommendation = !showRecommendation;
                });
              },
              child: const Text(
                "Recommended",
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (showRecommendation) ...[
              const SizedBox(height: 10),
              Text(
                "$chapterName",
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCustomButton("Buy", () {
                    // Action for the first elevated button
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.black,
                        content: Text(
                          "Done",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckoutScreen(),
                        ),
                      );
                    });
                  }),
                  _buildCustomButton("Buy All", () {
                    // Action for the second elevated button
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.black,
                        content: Text(
                          "Done",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisteredHomeScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
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

  Widget _buildCustomButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: faceBookColor),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(color: faceBookColor),
      ),
    );
  }
}
