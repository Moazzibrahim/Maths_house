import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/diagnostic/get_course_provider.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_duration.dart'; // Import ExamDuration screen
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
  bool showRecommendation = false;
  List<Map<String, dynamic>> chapterDetails = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<GetCourseProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<Map<String, dynamic>>(
          future: provider.fetchDataFromApi({
            'timer': widget.seconds,
            'r_question': widget.correctCount,
            'exam_id': widget.exid,
            'mistakes': widget.wrongQuestionIds,
          }, context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              int? grade = snapshot.data!['score'] as int?;
              chapterDetails =
                  (snapshot.data!['recommandition'] as List<dynamic>)
                      .where((recommendation) =>
                          recommendation['chapter_name'] != null)
                      .map((recommendation) {
                return {
                  'chapterName': recommendation['chapter_name'],
                  'id': recommendation['id'],
                  'price':
                      (recommendation['price'][0]['price'] ?? 0).toDouble(),
                  'duration': (recommendation['price'][0]['duration'] ?? 0),
                };
              }).toList();
              return _buildResultScreen(
                context,
                grade,
                chapterDetails,
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        );
      },
    );
  }

  Widget _buildResultScreen(BuildContext context, int? grade,
      List<Map<String, dynamic>> chapterDetails) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false); // Prevent back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Result",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          leading: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: gridHomeColor, borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: faceBookColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TabsScreen(
                      isLoggedIn: false,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInfoRow("Total Score", "${widget.score}"),
                const SizedBox(height: 15),
                _buildInfoRow("Grade", "$grade"),
                const SizedBox(height: 15),
                _buildInfoRow("Total Questions", "${widget.totalQuestions}"),
                const SizedBox(height: 15),
                _buildInfoRow("Correct Questions", "${widget.correctCount}"),
                const SizedBox(height: 15),
                _buildInfoRow("Wrong Questions", "${widget.wrongCount}"),
                const SizedBox(height: 25),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: faceBookColor),
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
                  _buildRecommendationSection(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: faceBookColor),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TabsScreen(
                            isLoggedIn: false,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationSection() {
    if (chapterDetails.isEmpty) {
      return const Text(
        "No chapters available",
        style: TextStyle(fontSize: 16, color: Colors.black),
      );
    }

    return Column(
      children: [
        ...chapterDetails.map((chapter) {
          return Column(
            children: [
              Text(
                chapter['chapterName'],
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCustomButton("Buy", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamDuration(
                          chapterNames: chapterDetails
                              .map(
                                  (chapter) => chapter['chapterName'] as String)
                              .toList(),
                          ids: chapterDetails
                              .map((chapter) => chapter['id'] as int)
                              .toList(),
                          prices: chapterDetails
                              .map((chapter) => chapter['price'] as double)
                              .toList(),
                          durations: chapterDetails
                              .map((chapter) => chapter['duration'] as int)
                              .toList(),
                          discounts: List<double>.filled(
                              chapterDetails.length, 0), // Adjust accordingly
                          // types: List<String>.filled(chapterDetails.length,
                          //     'Chapters'), // Adjust accordingly
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 10),
            ],
          );
        }),
        const SizedBox(height: 10),
      ],
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
