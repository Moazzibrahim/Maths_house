// ignore_for_file: avoid_print, unused_local_variable, unused_element, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/Diagnostic_exams/diagnostic_result_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Timer_provider.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_exam_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StartDiagnostic extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const StartDiagnostic({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diagnostic Exam"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: faceBookColor,
          ),
        ),
      ),
      body: const DiagnosticBody(),
    );
  }
}

class DiagnosticBody extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const DiagnosticBody({Key? key});

  @override
  State<DiagnosticBody> createState() => _DiagnosticBodyState();
}

class _DiagnosticBodyState extends State<DiagnosticBody> {
  int _currentQuestionIndex = 0;
  late DateTime startTime;
  List<int> wrongQuestionIds = [];
  DateTime? endTime;
  Duration? elapsedTime;
  List<String?> selectedAnswers = [];

  @override
  void initState() {
    fetchdata();
    super.initState();
    startTime = DateTime.now();
  }

  Future<void> fetchdata() async {
    final diagprov = Provider.of<DiagExamProvider>(context, listen: false);
    final data = await diagprov.fetchDataFromApi(context);
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context, listen: false);
    final diagProvider = Provider.of<DiagExamProvider>(context);
    final int idd =
        diagProvider.exid; // assuming a default value of 0 if exid is null
    final List<Map<String, dynamic>> allDiagnostics =
        diagProvider.alldiagnostics;
    List<String?> selectedAnswers = List.filled(allDiagnostics.length, null);
    final bool hasData = allDiagnostics.isNotEmpty;
    final Map<String, dynamic> questionData =
        hasData ? allDiagnostics[_currentQuestionIndex] : {};

    void goToNextQuestion() {
      if (_currentQuestionIndex < allDiagnostics.length - 1) {
        setState(() {
          _currentQuestionIndex++;
        });
      }
    }

    void goToPreviousQuestion() {
      if (_currentQuestionIndex > 0) {
        setState(() {
          _currentQuestionIndex--;
        });
      }
    }

    void navigateToQuestion(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Go to Question'),
            children: List.generate(
              allDiagnostics.length,
              (index) => SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    _currentQuestionIndex = index;
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

    void postDiagExamResults(int correctAnswerCount, Duration? elapsedTime,
        List<int> wrongQuestionIds) async {
      const url =
          'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_dia_exam_grade';
      final startExamProvider =
          Provider.of<DiagExamProvider>(context, listen: false);
      final examId = startExamProvider.exid;

      // Check if elapsedTime is null, if so, initialize it to Duration.zero
      elapsedTime ??= Duration.zero;
      // Calculate elapsed time in minutes and seconds as a combined string
      final String elapsed =
          '${elapsedTime.inMinutes}:${(elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}';
      final int elapsedMinutes = elapsedTime.inMinutes;
      final int elapsedSeconds = elapsedTime.inSeconds % 60;

      final Map<String, dynamic> postData = {
        'exam_id': examId,
        'right_question': correctAnswerCount,
        'timer': elapsedMinutes,
        'mistakes': wrongQuestionIds,
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
          print(' Diag Exam results posted successfully.');
          print("exam id: $examId");
        } else {
          print('Failed to post exam results: ${response.statusCode}');
          // Print response body for more details
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Error posting exam results: $e');
      }
    }

    void onChanged(String value, int index) {
      setState(() {
        selectedAnswers[_currentQuestionIndex] =
            value; // Update selected answer
      });
    }

    String _convertIndexToLetter(int index) {
      switch (index) {
        case 1:
          return 'A';
        case 2:
          return 'B';
        case 3:
          return 'C';
        case 4:
          return 'D';
        default:
          return 'Invalid index';
      }
    }

    void submitAnswers() {
      int correctAnswerCount = 0;
      List<Map<String, dynamic>> wrongAnswerQuestions = [];
      List<int> wrongQuestionIds = [];
      int totalQuestions = allDiagnostics.length;
      DateTime endTime = DateTime.now();
      Duration elapsedTime = endTime.difference(startTime);
      print(
          'Time taken: ${elapsedTime.inMinutes} minutes and ${elapsedTime.inSeconds % 60} seconds');

      for (int i = 0; i < totalQuestions; i++) {
        final Map<String, dynamic> questionData = allDiagnostics[i];
        final List<Map<String, dynamic>>? mcqData =
            questionData['mcq'] as List<Map<String, dynamic>>?;
        final List<String?> selectedAnswers = (questionData['mcq'] as List)
            .map((mcq) => mcq['mcq_ans']?.toString())
            .toList();
        final List<String?> correctAnswers = (mcqData ?? [])
            .map((mcq) => mcq['mcq_answers']?.toString())
            .toList();
        // Extract correct answers for the current question

        print('Correct answer for Question ${i + 1}: $correctAnswers');

        final selectedAnswerIndex = selectedAnswers[i] != null
            ? mcqData?.indexWhere(
                    (mcq) => mcq['mcq_ans'] == selectedAnswers[i]) ??
                -1
            : -1;

        final selectedAnswer = selectedAnswerIndex != -1
            ? _convertIndexToLetter(
                selectedAnswerIndex + 1) // Add 1 to adjust for starting from 1
            : 'Invalid index';

        print('Question ${i + 1}:');
        print('Selected Answer: $selectedAnswer');
        print('Correct answer: ${correctAnswers[i]}');

        if (selectedAnswer == correctAnswers[i]) {
          correctAnswerCount++;
        } else {
          wrongAnswerQuestions.add({
            'question': questionData,
            'selectedAnswer': selectedAnswer,
            'correctAnswer': correctAnswers[i],
          });
          final int questionId = questionData['id'] ?? -1;
          wrongQuestionIds.add(questionId);
        }
      }

      int wrongAnswerCount = wrongAnswerQuestions.length;

      print('Total Questions: $totalQuestions');
      print('Correct Answers: $correctAnswerCount');
      print('Wrong Answers: $wrongAnswerCount');
      print('Wrong Answer Questions: $wrongAnswerQuestions');
      print('Wrong Question IDs: $wrongQuestionIds');

      timerProvider.stopTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your answers are submitted')),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiagnosticResultScreen(
              wrongAnswerQuestions: wrongAnswerCount,
              correctAnswerCount: correctAnswerCount,
              totalQuestions: totalQuestions,
            ),
          ),
        );
      });
    }

    final String questionText =
        questionData['question'] ?? 'Question not available';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1}: $questionText',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (questionText != 'Question not available' &&
                      questionData.containsKey('mcq') &&
                      questionData['mcq'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (questionData['q_url'] != null)
                          // Image.network(
                          //   questionData['q_url'],
                          //   width: double.infinity,
                          //   fit: BoxFit.cover,
                          // ),
                          const SizedBox(
                              height: 8), // Adjust the spacing as needed
                        ...List.generate(
                          (questionData['mcq'] as List).length,
                          (index) {
                            final mcq = questionData['mcq'][index];
                            final mcqAns =
                                mcq['mcq_ans']; // Change type to dynamic
                            return RadioListTile(
                              title: Text(mcq['mcq_ans']?.toString() ??
                                  ''), // Ensure mcq_ans is converted to String
                              value: mcqAns,
                              groupValue:
                                  selectedAnswers[_currentQuestionIndex],
                              onChanged: (value) {
                                setState(() {
                                  selectedAnswers[_currentQuestionIndex] =
                                      value;
                                  print("Selected Answer: $value");
                                  print("${selectedAnswers}");
                                });
                              },
                            );
                          },
                        ),
                      ],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your answer...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
              onPressed: goToPreviousQuestion,
              child: const Text(
                'Previous',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                navigateToQuestion(context);
              },
              child: const Text(
                'Go to Question',
                style: TextStyle(color: faceBookColor),
              ),
            ),
            ElevatedButton(
              onPressed: _currentQuestionIndex < allDiagnostics.length - 1
                  ? goToNextQuestion
                  : submitAnswers,
              style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
              child: Text(
                _currentQuestionIndex < allDiagnostics.length - 1
                    ? 'Next'
                    : 'Submit',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
