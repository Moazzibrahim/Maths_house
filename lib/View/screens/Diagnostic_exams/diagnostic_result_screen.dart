import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/View/screens/registered_home_screen.dart';
import 'package:flutter_application_1/controller/diagnostic/get_course_provider.dart';
import 'package:provider/provider.dart';

class DiagnosticResultScreen extends StatelessWidget {
  final int wrongCount;
  final int correctCount;
  final int totalQuestions;
  final int? score;
  final int? passscore;
  final int? seconds;
  final List<int> wrongQuestionIds;

  const DiagnosticResultScreen({
    super.key,
    required this.wrongCount,
    required this.correctCount,
    required this.totalQuestions,
    this.score,
    this.passscore,
    this.seconds,
    required this.wrongQuestionIds,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GetCourseProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<Map<String, dynamic>>(
          future: provider.fetchDataFromApi({
            'timer_count': seconds, // Change this to the appropriate value
            'correct_count': correctCount,
            'wrong_count': wrongCount,
            'wrong_question_ids':
                wrongQuestionIds, // Change this to the appropriate value
          }, context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              // Process the fetched data and update the UI accordingly
              // Example: Extract data from snapshot.data and display it
              return _buildResultScreen(context);
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        );
      },
    );
  }

  Widget _buildResultScreen(BuildContext context) {
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
            _buildInfoRow("total score", "${score ?? ''}"),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("grade", "5"), // Change this to the appropriate value
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Total Questions", " $totalQuestions"),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Correct Questions", "$correctCount"),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Wrong Questions", "$wrongCount"),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
              onPressed: () {
                // Toggle showRecommendation state
                showRecommendation = !showRecommendation;
              },
              child: const Text(
                "Recommended",
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (showRecommendation) ...[
              const SizedBox(height: 10),
              const Text(
                "Chapter 1",
                style: TextStyle(fontSize: 16, color: Colors.black),
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
