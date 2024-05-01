// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/exam_history_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ExamResultScreen extends StatefulWidget {
  final int? wrongAnswerQuestions;
  final int? correctAnswerCount;
  final int? totalQuestions;
  final Map<String, dynamic>? examresults;

  const ExamResultScreen({
    super.key,
    this.correctAnswerCount,
    this.wrongAnswerQuestions,
    this.totalQuestions,
    this.examresults,
  });

  @override
  State<ExamResultScreen> createState() => _DiagnosticResultScreenState();
}

class _DiagnosticResultScreenState extends State<ExamResultScreen> {
  bool showRecommendation = false;
  Map<String, dynamic> examResultData = {};

  @override
  void initState() {
    super.initState();
    fetchExamResults().then((data) {
      setState(() {
        examResultData =
            data; // Assuming you want the discount from the first item in the price array
      });
    }).catchError((error) {
      print('Error fetching exam results: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    int? totalQuestions = widget.totalQuestions;
    int? correctAnswerCount = widget.correctAnswerCount;
    int? wrongAnswerQuestions = widget.wrongAnswerQuestions;

    // Accessing data from examresults map
    int? grade = widget.examresults?['grade'];
    int? totalScore = widget.examresults?['total_score'];
    String? chapterName = widget.examresults?['chapters'][0]['api_lesson']
        ['api_chapter']['chapter_name'];
    int? duration = widget.examresults?['chapters'][0]['api_lesson']
        ['api_chapter']['price'][0]['duration'];
    int? price = widget.examresults?['chapters'][0]['api_lesson']['api_chapter']
        ['price'][0]['price'];
    int? discount = widget.examresults?['chapters'][0]['api_lesson']
        ['api_chapter']['price'][0]['discount'];

    return Scaffold(
      appBar: buildAppBar(context, "Result"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoRow("total score", totalScore.toString()),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("grade", grade.toString()),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Total Questions", totalQuestions.toString()),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Correct Questions", correctAnswerCount.toString()),
            const SizedBox(
              height: 15,
            ),
            _buildInfoRow("Wrong Questions", wrongAnswerQuestions.toString()),
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
              Text("$chapterName",
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
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
                          builder: (context) => const ExamHistoryScreen()));
                },
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

  Future<Map<String, dynamic>> fetchExamResults() async {
    // Replace 'api_endpoint_url' with the actual URL of your API endpoint
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    final response = await http.get(
      Uri.parse(
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam_grade',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response body
      Map<String, dynamic> data = json.decode(response.body);
      print(data);
      return data;
    } else {
      // If the request fails, throw an error
      throw Exception('Failed to fetch exam results');
    }
  }
}
