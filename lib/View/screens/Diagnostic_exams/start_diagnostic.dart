// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/Diagnostic_exams/diagnostic_result_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Timer_provider.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_exam_provider.dart';
import 'package:provider/provider.dart';

class StartDiagnostic extends StatelessWidget {
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
              questionData.length,
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

    void submitAnswers() {
      int correctAnswerCount = 0;
      List<Map<String, dynamic>> wrongAnswerQuestions = [];
      List<int> wrongQuestionIds = [];
      int totalQuestions = 0;

      for (int i = 0; i < allDiagnostics.length; i++) {
        final Map<String, dynamic> questionData = allDiagnostics[i];
        final List<Map<String, dynamic>> mcqData =
            questionData['mcq'] as List<Map<String, dynamic>>;
        final String correctAnswer = mcqData[0]['mcq_answers'];
        totalQuestions = allDiagnostics
            .length; // Assuming correct answer is the same for all options

        if (selectedAnswers[i] == correctAnswer) {
          correctAnswerCount++;
        } else {
          wrongAnswerQuestions.add(
              questionData); // Add the entire question data to the list of wrong questions
          final int questionId = questionData['question_with_ans'] != null
              ? questionData['question_with_ans']['id']
              : -1;

          wrongQuestionIds
              .add(questionId); // Add the ID of wrong question to the list
        }
      }

      int wrongAnswerCount = wrongAnswerQuestions.length;

      // Now you have counts and details of wrong questions along with their IDs
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
              totalQuestions: allDiagnostics.length,
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
                      children: List.generate(
                        (questionData['mcq'] as List).length,
                        (index) {
                          final mcq = questionData['mcq'][index];
                          final mcqAns = mcq['mcq_ans']
                              as String; // Assuming mcq_ans is a String
                          return RadioListTile(
                            title: Text(mcq['mcq_ans'] ?? ''),
                            value: mcqAns,
                            groupValue: selectedAnswers[_currentQuestionIndex],
                            onChanged: (value) {
                              setState(() {
                                selectedAnswers[_currentQuestionIndex] = value;
                                print("Selected Answer: $value");
                                print(
                                    "${selectedAnswers[_currentQuestionIndex]}"); // Print selected answer
                              });
                            },
                          );
                        },
                      ),
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
