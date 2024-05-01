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
            Icons.arrow_back_ios,
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
  DateTime? endTime;
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
    final mcqprovider = Provider.of<ExamMcqProvider>(context,
        listen: false); // Assuming examId is available in ExamMcqProvider
    final data = await mcqprovider.fetchExamDataFromApi(
      context,
    );

    setState(() {
      questionsWithAnswers = data;
    });
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
              examresults: examResults, // Pass the fetched exam results data
              // Pass other required arguments if needed
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
              return Text(
                "Timer: ${timer.secondsSpent ~/ 60}:${(timer.secondsSpent % 60).toString().padLeft(2, '0')}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
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
                                .selectedSolutionIndex = value;
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ExamResultScreen(
                    //       correctAnswerCount: correctAnswerCount,
                    //       totalQuestions: totalQuestions,
                    //       wrongAnswerQuestions: wrongAnswerCount,
                    //     ),
                    //   ),
                    // );
                    final examId = startExamProvider.examId;
                    fetchAndNavigateToExamResultScreen({
                      'exam_id': examId,
                      'right_question': correctAnswerCount,
                      'timer': elapsedTime.inMinutes,
                      'mistakes': wrongQuestionIds,
                    });
                  }); // Stop timer
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Answers submitted.'),
                    ),
                  );
                  submitAnswers(questionsWithAnswers!);
                  // postExamResults(
                  //   correctAnswerCount,
                  //   elapsedTime, // Pass wrongQuestionIds here
                  // );
                  final examId = startExamProvider.examId;
                  wrongQuestionIds = submitAnswers(questionsWithAnswers!);
                  fetchExamResults({
                    'exam_id': examId,
                    'right_question': correctAnswerCount,
                    'timer': elapsedTime.inMinutes,
                    'mistakes': wrongQuestionIds,
                  });
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

  void postExamResults(int correctAnswerCount, Duration? elapsedTime) async {
    const url =
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam_grade';
    final startExamProvider =
        Provider.of<StartExamProvider>(context, listen: false);
    final examId = startExamProvider.examId;

    // Check if elapsedTime is null, if so, initialize it to Duration.zero
    elapsedTime ??= Duration.zero;
    // Calculate elapsed time in minutes and seconds as a combined string
    final String elapsed =
        '${elapsedTime.inMinutes}:${(elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}';
    final int elapsedMinutes = elapsedTime.inMinutes;
    final int elapsedSeconds = elapsedTime.inSeconds % 60;
    wrongQuestionIds = submitAnswers(questionsWithAnswers!);

    final Map<String, dynamic> postData = {
      'exam_id': examId,
      'right_question': correctAnswerCount,
      'timer': elapsedMinutes,
      'mistakes': wrongQuestionIds, // Include wrongQuestionIds directly
    };

    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token; // Replace with your auth token

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(postData),
      );

      if (response.statusCode == 200) {
        print('Exam results posted successfully.');
        print("exam id: $examId");
        print(response.body);
      } else {
        print('Failed to post exam results: ${response.statusCode}');
        // Print response body for more details
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error posting exam results: $e');
    }
  }

  Future<Map<String, dynamic>?>? fetchExamResults(
      Map<String, dynamic> postData) async {
    const baseUrl =
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam_grade';
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token; // Replace with your auth token

    // Construct the query parameters
    String queryParams = '';
    postData.forEach((key, value) {
      queryParams += '$key=$value&';
    });
    final Uri uri = Uri.parse('$baseUrl?$queryParams');

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
        // Decode the response body
        final Map<String, dynamic> data = json.decode(response.body);

        // Process the data as needed
        print('Exam results retrieved successfully:');
        print(data);
        return data;
      } else {
        print('Failed to retrieve exam results: ${response.statusCode}');
        // Print response body for more details
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
  int totalQuestions = 0; // Counter for total questions

  List<int> submitAnswers(List<QuestionWithAnswers> questionsWithAnswers) {
    // Clear wrong answer questions list before checking again
    wrongAnswerQuestions.clear();
    correctAnswerCount = 0;
    wrongAnswerCount = 0;
    totalQuestions =
        questionsWithAnswers.length; // Initialize total questions counter
    DateTime endTime = DateTime.now();
    Duration elapsedTime = endTime.difference(startTime);
    print(
        'Time taken: ${elapsedTime.inMinutes} minutes and ${elapsedTime.inSeconds % 60} seconds');

    for (var i = 0; i < totalQuestions; i++) {
      final selectedAnswerIndex = questionsWithAnswers[i].selectedSolutionIndex;
      final correctAnswerIndex = questionsWithAnswers[i]
          .answers
          // ignore: unnecessary_null_comparison
          .indexWhere((answer) => answer.mcqAns != null);

      // Check if both selected answer and correct answer are valid
      if (selectedAnswerIndex != null && correctAnswerIndex != -1) {
        // Compare the positions of selected answer and correct answer
        if (selectedAnswerIndex == correctAnswerIndex) {
          correctAnswerCount++;
        } else {
          // Add the question to the list of wrong answer questions
          wrongAnswerQuestions.add({
            'question': questionsWithAnswers[i].question,
            'selectedAnswer': String.fromCharCode(selectedAnswerIndex +
                65), // Convert index to letter representation
            'correctAnswer': String.fromCharCode(correctAnswerIndex +
                65), // Convert index to letter representation
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
    // Extract wrong question IDs and add them to wrongQuestionIds list
    for (var question in wrongAnswerQuestions) {
      // Assuming 'id' is the key for question IDs
      final questionId = question['question'].id;
      wrongQuestionIds.add(questionId);
      print(wrongQuestionIds);
    }
    return wrongQuestionIds;
  }
}
