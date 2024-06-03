// ignore_for_file: avoid_print, unused_local_variable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/exam_models/exam_mcq_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_result.dart';
import 'package:flutter_application_1/View/screens/registered_home_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Timer_provider.dart';
import 'package:flutter_application_1/controller/exam/exam_mcq_provider.dart';
import 'package:flutter_application_1/controller/exam/start_exam_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExamScreen extends StatefulWidget {
  final int? fetchedexamid;
  const ExamScreen({Key? key, this.fetchedexamid}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam"),
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: faceBookColor,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RegisteredHomeScreen()));
          },
        ),
      ),
      body: ExamBody(
        fetchedexamids: widget.fetchedexamid,
      ),
    );
  }
}

class ExamBody extends StatefulWidget {
  final int? fetchedexamids;
  const ExamBody({super.key, this.fetchedexamids});

  @override
  _ExamBodyState createState() => _ExamBodyState();
}

class _ExamBodyState extends State<ExamBody> {
  int _questionIndex = 0;
  bool _isSubmitting = false;
  List<QuestionWithAnswers>? questionsWithAnswers;
  late DateTime startTime;
  Duration elapsedTime = Duration.zero;
  List<int> wrongQuestionIds = [];
  int questionsSolved = 0;

  @override
  void initState() {
    super.initState();
    fetchExamData();
    // Record the start time when the exam screen is initialized
    startTime = DateTime.now();
  }

  Future<void> fetchExamData() async {
    final mcqprovider = Provider.of<ExamMcqProvider>(context, listen: false);
    print('Attempting to fetch exam data...');
    try {
      final data = await mcqprovider.fetchExamDataFromApi(context);
      print('Exam data successfully fetched: $data');
      setState(() {
        questionsWithAnswers = data;
      });
    } catch (e) {
      print('Error fetching exam data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context, listen: false);
    final startExamProvider =
        Provider.of<StartExamProvider>(context, listen: false);
    log("exxxid: ${widget.fetchedexamids}");

    if (questionsWithAnswers == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (questionsWithAnswers!.isEmpty) {
      return const Center(
        child: Text("No questions available"),
      );
    }

    Future<void> fetchAndNavigateToExamResultScreen(
        Map<String, dynamic> postData) async {
      try {
        final Map<String, dynamic>? examResults =
            await fetchExamResults(postData);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExamResultScreen(
              examresults: examResults,
              correctAnswerCount: correctAnswerCount,
              totalQuestions: totalQuestions,
              wrongAnswerQuestions: wrongAnswerCount,
              elapsedtime: elapsedTime.inMinutes,
              wrongids: wrongQuestionIds,
              exxxid: widget.fetchedexamids,
            ),
          ),
        );
      } catch (e) {
        print('Error fetching exam results: $e');
        // Handle error, e.g., show error dialog
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: faceBookColor,
            child: Consumer<TimerProvider>(
              builder: (context, timer, child) {
                return Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      " ${timer.secondsSpent ~/ 60}:${(timer.secondsSpent % 60).toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                        width: 100
                            .w), // Spacing between timer and solved questions
                    Text(
                      "Solved: $questionsSolved / $totalQuestions questions",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_questionIndex < questionsWithAnswers!.length)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Question ${_questionIndex + 1}:",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (questionsWithAnswers![_questionIndex]
                                  .questiondata[0]
                                  .qUrl !=
                              null &&
                          questionsWithAnswers![_questionIndex]
                              .questiondata[0]
                              .qUrl!
                              .isNotEmpty)
                        Image.network(
                          questionsWithAnswers![_questionIndex]
                              .questiondata[0]
                              .qUrl!,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(height: 20.0),
                      if (questionsWithAnswers![_questionIndex]
                              .questiondata[0]
                              .ansType ==
                          'MCQ')
                        Column(
                          children: List.generate(
                            questionsWithAnswers![_questionIndex].mcqOptions.length,
                            (index) => RadioListTile(
                              title: Text(
                                " ${questionsWithAnswers![_questionIndex].answers[index].mcqnum!}.",
                              ),
                              value: index,
                              groupValue: questionsWithAnswers![_questionIndex]
                                  .selectedSolutionIndex,
                              onChanged: (value) {
                                setState(() {
                                  questionsWithAnswers![_questionIndex]
                                      .selectedSolutionIndex = value as int;
                                  updateQuestionsSolved();
                                });
                              },
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Enter your answer',
                              border: OutlineInputBorder(),
                            ),
                            // Handle text input for non-MCQ questions
                            onChanged: (value) {
                              // You can store the entered text in your data model or handle it as needed
                            },
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!_isSubmitting && _questionIndex > 0)
                ElevatedButton(
                  onPressed: goToPreviousQuestion,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: faceBookColor),
                  child: const Text(
                    "Previous",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  _navigateToQuestion(context);
                },
                child: Text(
                  "Question ${_questionIndex + 1}",
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              if (!_isSubmitting &&
                  _questionIndex < questionsWithAnswers!.length - 1)
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: faceBookColor),
                  onPressed: goToNextQuestion,
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              if (_questionIndex == questionsWithAnswers!.length - 1)
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: faceBookColor),
                  onPressed: () {
                    setState(() {
                      _isSubmitting = true;
                    });
                    timerProvider.stopTimer();
                    bool hasMissedQuestions = checkMissedQuestions();
                    if (!hasMissedQuestions) {
                      var postData = {
                        'exam_id': widget.fetchedexamids,
                        'answers': questionsWithAnswers!
                            .map((q) => q.selectedSolutionIndex)
                            .toList(),
                        'time_taken': elapsedTime.inSeconds,
                      };
                      fetchAndNavigateToExamResultScreen(postData);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Answers submitted.'),
                        ),
                      );
                      wrongQuestionIds = submitAnswers(questionsWithAnswers!);
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void goToNextQuestion() {
    setState(() {
      if (_questionIndex < questionsWithAnswers!.length - 1) {
        _questionIndex++;
      }
    });
  }

  void goToPreviousQuestion() {
    setState(() {
      if (_questionIndex > 0) {
        _questionIndex--;
      }
    });
  }

  void _navigateToQuestion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Go to Question'),
          children: List.generate(
            questionsWithAnswers!.length,
            (index) => SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _questionIndex = index;
                });
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Text(
                    questionsWithAnswers![index].selectedSolutionIndex != null
                        ? 'Solved'
                        : 'Missed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: questionsWithAnswers![index]
                                  .selectedSolutionIndex !=
                              null
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 20), // Adjust spacing as needed
                  Text(
                    "Question ${index + 1}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void updateQuestionsSolved() {
    setState(() {
      questionsSolved++; // Increment questions solved counter
    });
  }

  bool checkMissedQuestions() {
    List<int> missedQuestions = [];
    for (int i = 0; i < questionsWithAnswers!.length; i++) {
      if (questionsWithAnswers![i].selectedSolutionIndex == -1 ||
          questionsWithAnswers![i].selectedSolutionIndex == null) {
        missedQuestions.add(i);
      }
    }
    if (missedQuestions.isNotEmpty) {
      showMissedQuestionsDialog(missedQuestions);
      return true;
    } else {
      submitAnswers(questionsWithAnswers!);
      return false;
    }
  }

  void showMissedQuestionsDialog(List<int> missedQuestions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You have missed these questions:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              missedQuestions.length,
              (index) => ListTile(
                title: Text('Question ${missedQuestions[index] + 1}'),
                trailing: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: faceBookColor),
                  onPressed: () {
                    setState(() {
                      _questionIndex = missedQuestions[index];
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'View',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
                onPressed: () {
                  Navigator.pop(context);
                  submitAnswers(questionsWithAnswers!);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, dynamic>?> fetchExamResults(
      Map<String, dynamic> postData) async {
    const baseUrl =
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam_grade';
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    final Uri uri = Uri.parse(baseUrl);
    print('Attempting to fetch exam results with data: $postData');
    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Exam results retrieved successfully: $data');
        return data;
      } else {
        print('Failed to retrieve exam results: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch exam results');
      }
    } catch (e) {
      print('Error retrieving exam results: $e');
    }
    return null;
  }

  List<Map<String, dynamic>> wrongAnswerQuestions = [];
  int correctAnswerCount = 0;
  int wrongAnswerCount = 0;
  int totalQuestions = 0;

  List<int> submitAnswers(List<QuestionWithAnswers> questionsWithAnswers) {
    wrongAnswerQuestions.clear();
    correctAnswerCount = 0;
    wrongAnswerCount = 0;
    totalQuestions = questionsWithAnswers.length;

    DateTime endTime = DateTime.now();
    elapsedTime = endTime.difference(startTime);
    print(
        'Time taken: ${elapsedTime.inMinutes} minutes and ${elapsedTime.inSeconds % 60} seconds');

    for (var i = 0; i < totalQuestions; i++) {
      final selectedAnswerIndex = questionsWithAnswers[i].selectedSolutionIndex;
      final correctAnswerIndex = questionsWithAnswers[i]
          .answers
          .indexWhere((answer) => answer.mcqAns != null);
      log("selected answer: $selectedAnswerIndex");
      log("correct answer :$correctAnswerIndex ");

      if (selectedAnswerIndex != null && correctAnswerIndex != -1) {
        if (selectedAnswerIndex == correctAnswerIndex) {
          correctAnswerCount++;
        } else {
          wrongAnswerQuestions.add({
            'question': questionsWithAnswers[i].question,
            'selectedAnswer': String.fromCharCode(selectedAnswerIndex + 65),
            'correctAnswer': String.fromCharCode(correctAnswerIndex + 65),
          });
          wrongAnswerCount++;
        }
      }
    }

    print('Correct Answers: $correctAnswerCount');
    print('Wrong Answers: $wrongAnswerCount');
    print('Total Questions: $totalQuestions');

    print(wrongAnswerQuestions);

    List<int> wrongQuestionIds = [];
    print('Wrong Question IDs:');
    for (var question in wrongAnswerQuestions) {
      final questionId = question['question'].id;
      wrongQuestionIds.add(questionId);
      print(wrongQuestionIds);
    }
    return wrongQuestionIds;
  }
}
