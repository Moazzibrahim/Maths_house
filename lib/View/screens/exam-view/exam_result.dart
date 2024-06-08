import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_duration.dart';
import 'package:flutter_application_1/View/screens/history_screens/exam_history_screen.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/exam/get_exam_provider.dart';
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
    return Consumer<GetExamProvider>(
      builder: (context, provider, _) {
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
              return _buildResultScreen(context, snapshot.data!);
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        );
      },
    );
  }

  Widget _buildResultScreen(BuildContext context, Map<String, dynamic> data) {
    int grade = data['grade'] as int;
    int totalScore = data['total_score'] as int;
    int passScore = data['pass_score'] as int;

    List<String> chapterNames = [];
    List<int> ids = [];
    List<double> prices = [];
    List<int> durations = [];
    List<double> discounts = [];

    for (var chapter in data['chapters']) {
      var apiChapter = chapter['api_lesson']['api_chapter'];
      chapterNames.add(apiChapter['chapter_name']);
      ids.add(apiChapter['id']);
      prices.add(apiChapter['price'][0]['price'].toDouble());
      durations.add(apiChapter['price'][0]['duration']);
      discounts.add(apiChapter['price'][0]['discount'].toDouble());
    }

    // Removing duplicates
    Map<String, int> uniqueChapters = {};
    for (int i = 0; i < chapterNames.length; i++) {
      uniqueChapters[chapterNames[i]] = i;
    }

    List<String> uniqueChapterNames = uniqueChapters.keys.toList();
    List<int> uniqueIds = uniqueChapters.values.map((i) => ids[i]).toList();
    List<double> uniquePrices =
        uniqueChapters.values.map((i) => prices[i]).toList();
    List<int> uniqueDurations =
        uniqueChapters.values.map((i) => durations[i]).toList();
    List<double> uniqueDiscounts =
        uniqueChapters.values.map((i) => discounts[i]).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const TabsScreen(
                isLoggedIn: false,
              ),
            ));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: faceBookColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInfoRow("Total Score", totalScore.toString()),
              const SizedBox(height: 15),
              _buildInfoRow("Grade", grade.toString()),
              const SizedBox(height: 15),
              _buildInfoRow("Pass Score", passScore.toString()),
              const SizedBox(height: 15),
              _buildInfoRow("Total Questions", "${widget.totalQuestions}"),
              const SizedBox(height: 15),
              _buildInfoRow(
                  "Correct Questions", "${widget.correctAnswerCount}"),
              const SizedBox(height: 15),
              _buildInfoRow(
                  "Wrong Questions", "${widget.wrongAnswerQuestions}"),
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
                if (uniqueChapterNames.isEmpty)
                  const Text("No recommended chapters available",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                for (int i = 0; i < uniqueChapterNames.length; i++) ...[
                  Text(uniqueChapterNames[i],
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
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
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExamDuration(
                                chapterNames: uniqueChapterNames,
                                discounts: uniqueDiscounts,
                                ids: uniqueIds,
                                durations: uniqueDurations,
                                prices: uniquePrices,
                              ),
                            ),
                          );
                        });
                      }),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: faceBookColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExamHistoryScreen(),
                      ),
                    );
                  },
                  child: const Text("View Mistakes",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 15),
              ],
            ],
          ),
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
