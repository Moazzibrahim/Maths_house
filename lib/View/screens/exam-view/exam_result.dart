import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class ExamResultScreen extends StatefulWidget {
  final int? correctAnswerCount;
  const ExamResultScreen({super.key, this.correctAnswerCount});

  @override
  State<ExamResultScreen> createState() => _DiagnosticResultScreenState();
}

class _DiagnosticResultScreenState extends State<ExamResultScreen> {
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
            _buildInfoRow("Total Questions", "10"),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow(
                "Correct Questions", widget.correctAnswerCount.toString()),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Wrong Questions", "0"),
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
                onPressed: () {},
                child: const Text("View mistakes",
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 15),
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
