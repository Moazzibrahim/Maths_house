// ignore_for_file: avoid_print, unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/exam_history_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/exam/get_exam_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ExamResultScreen extends StatefulWidget {
  final int? wrongAnswerQuestions;
  final int? correctAnswerCount;
  final int? totalQuestions;
  final Map<String, dynamic>? examresults;
  final int? elapsedtime;
  final int? exxxid;
  final List<int>? wrongids;

  const ExamResultScreen({
    super.key,
    this.correctAnswerCount,
    this.wrongAnswerQuestions,
    this.totalQuestions,
    this.examresults,
    this.elapsedtime,
    this.exxxid,
    this.wrongids,
  });

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
  bool showRecommendation = false;
 

  @override
  Widget build(BuildContext context) {
    int? totalQuestions = widget.totalQuestions;
    int? correctAnswerCount = widget.correctAnswerCount;
    int? wrongAnswerQuestions = widget.wrongAnswerQuestions;

    return Consumer<GetExamProvider>(builder: (context, provider, _) {
      return FutureBuilder<Map<String, dynamic>?>(
        future: provider.fetchExamResults({
          "exam_id": widget.exxxid,
          "timer": widget.elapsedtime,
          "right_question": widget.correctAnswerCount,
          "mistakes": widget.wrongids,
        }, context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            int grade = snapshot.data!['grade'] as int;
            int totalscore = snapshot.data!['total_score'] as int;
            int passscore = snapshot.data!['pass_score'] as int;
            String chapterName = snapshot.data!['chapters'][0]['api_lesson']
                    ['api_chapter']['chapter_name'] ??
                "";
            int id = snapshot.data!['chapters'][0]['api_lesson']['api_chapter']
                    ['id'] ??
                0;
            String type = snapshot.data!['chapters'][0]['api_lesson']
                    ['api_chapter']['type'] ??
                "";
            double price = snapshot.data!['chapters'][0]['api_lesson']
                        ['api_chapter']['price'][0]['price']
                    ?.toDouble() ??
                0.5;
            int duration = snapshot.data!['chapters'][0]['api_lesson']
                    ['api_chapter']['price'][0]['duration'] ??
                0;
            double discount = snapshot.data!['chapters'][0]['api_lesson']
                        ['api_chapter']['price'][0]['discount']
                    ?.toDouble() ??
                0.5;

            return Scaffold(
              appBar: buildAppBar(context, "Result"),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildInfoRow("total score", totalscore.toString()),
                    const SizedBox(height: 15),
                    _buildInfoRow("grade", grade.toString()),
                    const SizedBox(height: 15),
                    _buildInfoRow("Total Questions", "$totalQuestions"),
                    const SizedBox(height: 15),
                    _buildInfoRow(
                        "Correct Questions", correctAnswerCount.toString()),
                    const SizedBox(height: 15),
                    _buildInfoRow(
                        "Wrong Questions", wrongAnswerQuestions.toString()),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: faceBookColor),
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
                      Text(chapterName,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCustomButton("Buy", () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  "Done",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                            fetchExamResults();
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutScreen(
                                    chapterName: chapterName,
                                    // discount: discount,
                                    duration: duration,
                                    price: price,
                                    type: type,
                                    id: id,
                                  ),
                                ),
                              );
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: faceBookColor),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ExamHistoryScreen(),
                            ),
                          );
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
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      );
    });
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
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    final response = await http.get(
      Uri.parse(
          'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam_grade'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print(data);
      return data;
    } else {
      throw Exception('Failed to fetch exam results');
    }
  }
}
