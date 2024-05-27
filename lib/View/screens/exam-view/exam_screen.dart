// ignore_for_file: library_private_types_in_public_api, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_result.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Timer_provider.dart';
import 'package:flutter_application_1/controller/exam/exam_mcq_provider.dart';
import 'package:flutter_application_1/controller/exam/start_exam_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

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
            Navigator.pop(context);
          },
        ),
      ),
      body: const ExamBody(),
    );
  }
}

class ExamBody extends StatefulWidget {
  const ExamBody({super.key});

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
            ),
          ),
        );
      } catch (e) {
        print('Error fetching exam results: $e');
        // Handle error, e.g., show error dialog
      }
    }

    return Column(
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
                ],
              );
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question ${_questionIndex + 1}: ${questionsWithAnswers![_questionIndex].question.questionText ?? ''}",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                if (questionsWithAnswers![_questionIndex].question.ansType ==
                    'MCQ')
                  Column(
                    children: List.generate(
                      questionsWithAnswers![_questionIndex].mcqOptions.length,
                      (index) => RadioListTile(
                        title: Text(
                          questionsWithAnswers![_questionIndex]
                              .mcqOptions[index],
                        ),
                        value: index,
                        groupValue: questionsWithAnswers![_questionIndex]
                            .selectedSolutionIndex,
                        onChanged: (value) {
                          setState(() {
                            questionsWithAnswers![_questionIndex]
                                .selectedSolutionIndex = value as int;
                          });
                        },
                      ),
                    ),
                  ),
                if (questionsWithAnswers![_questionIndex].question.ansType !=
                    'MCQ')
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
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!_isSubmitting && _questionIndex > 0)
              ElevatedButton(
                onPressed: goToPreviousQuestion,
                style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
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
                style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
                onPressed: goToNextQuestion,
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            if (_questionIndex == questionsWithAnswers!.length - 1)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
                onPressed: () {
                  setState(() {
                    _isSubmitting = true;
                  });
                  timerProvider.stopTimer();
                  Future.delayed(const Duration(seconds: 1), () {
                    final examId = startExamProvider.examId;
                    fetchAndNavigateToExamResultScreen({
                      'exam_id': examId,
                      'right_question': correctAnswerCount,
                      'timer': elapsedTime.inMinutes,
                      'mistakes': wrongQuestionIds,
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Answers submitted.'),
                    ),
                  );
                  wrongQuestionIds = submitAnswers(questionsWithAnswers!);
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ],
    );
  }

  void goToNextQuestion() {
    setState(() {
      _questionIndex++;
    });
  }

  void goToPreviousQuestion() {
    setState(() {
      _questionIndex--;
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
              child: Text("Question ${index + 1}"),
            ),
          ),
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

    final Uri uri = Uri.parse('$baseUrl');
    print('Attempting to fetch exam results with data: $postData');
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(postData),
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
          .indexWhere((answer) => answer.mcqAns == true);

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
