import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/View/screens/registered_home_screen.dart';

class DiagnosticResultScreen extends StatefulWidget {
  final int? wrongAnswerQuestions;
  final int? correctAnswerCount;
  final int? totalQuestions;

  const DiagnosticResultScreen(
      {super.key,
      this.wrongAnswerQuestions,
      this.correctAnswerCount,
      this.totalQuestions});

  @override
  State<DiagnosticResultScreen> createState() => _DiagnosticResultScreenState();
}

class _DiagnosticResultScreenState extends State<DiagnosticResultScreen> {
  bool showRecommendation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Result"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoRow("Quizzes", "ADf"),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Score", "5"),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Total Questions", " ${widget.totalQuestions}"),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Correct Questions", "${widget.correctAnswerCount}"),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Wrong Questions", "${widget.wrongAnswerQuestions}"),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
              onPressed: () {
                setState(() {
                  showRecommendation = !showRecommendation;
                });
              },
              child: const Text("Recommended",
                  style: TextStyle(color: Colors.white)),
            ),
            if (showRecommendation) ...[
              const SizedBox(height: 10),
              const Text("Chapter 1",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
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
                            builder: (context) => const CheckoutScreen()),
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
                child:
                    const Text("Home", style: TextStyle(color: Colors.white)),
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
