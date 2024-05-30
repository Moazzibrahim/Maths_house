// ignore_for_file: avoid_print, use_build_context_synchronously, unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/Diagnostic_exams/diagnostic_result_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_exam_provider.dart';
import 'package:provider/provider.dart';

class DiagnosticExamScreen extends StatelessWidget {
  const DiagnosticExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Diagnostic Exam"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<DiagExamProvider>(
          builder: (context, provider, _) {
            if (provider.alldiagnostics.isEmpty) {
              // Data not loaded yet, fetch data
              provider.fetchDataFromApi(context);
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // Data loaded, display questions
              return DiagnosticQuestionsList(
                exid: provider.exid,
                score: provider.score,
              );
            }
          },
        ),
      ),
    );
  }
}

class DiagnosticQuestionsList extends StatefulWidget {
  final int exid;
  final int score;

  const DiagnosticQuestionsList(
      {super.key, required this.exid, required this.score});

  @override
  // ignore: library_private_types_in_public_api
  _DiagnosticQuestionsListState createState() =>
      _DiagnosticQuestionsListState();
}

class _DiagnosticQuestionsListState extends State<DiagnosticQuestionsList> {
  int currentIndex = 0;
  late Timer _timer;
  int _seconds = 0;
  List<int> missedQuestions = [];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _nextQuestion() {
    final provider = Provider.of<DiagExamProvider>(context, listen: false);
    if (currentIndex < provider.alldiagnostics.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void _prevQuestion() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  int countAnsweredQuestions() {
    final provider = Provider.of<DiagExamProvider>(context, listen: false);
    int answeredCount = 0;
    for (final question in provider.alldiagnostics) {
      if (question['selectedAnswer'] != null) {
        answeredCount++;
      }
    }
    return answeredCount;
  }

  void _showQuestionsDialog() {
    final provider = Provider.of<DiagExamProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Go to Question'),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(provider.alldiagnostics.length, (index) {
                final question = provider.alldiagnostics[index];
                final isAnswered = question['selectedAnswer'] != null;
                return ListTile(
                  title: Text('Question ${index + 1}'),
                  leading: Text(
                    isAnswered ? "solved" : "missed",
                    style: TextStyle(
                        color: isAnswered ? Colors.green : faceBookColor,
                        fontSize: 12),
                  ),
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void storeExamResults(
      int correctCount,
      int wrongCount,
      int seconds,
      List<int> wrongQuestionIds,
      int totalQuestions,
      int score,
      int passscore) {
    // Store the exam results as needed, e.g., in a database or shared preferences
    print('Correct Answers: $correctCount');
    print('Wrong Answers: $wrongCount');
    print('Time taken: $seconds minutes');
    print('Total Questions: $totalQuestions');
    print('Wrong Question IDs: $wrongQuestionIds');
    print('exid: ${widget.exid}');
    print('score: ${widget.score}');
  }

  void _submitExam(BuildContext context) async {
    _timer.cancel();
    final provider = Provider.of<DiagExamProvider>(context, listen: false);
    int unansweredIndex = -1;
    List<int> wrongQuestionIds = [];
    final int score = provider.score;
    final int passscore = provider.passscore;
    int correctCount = 0;
    int wrongCount = 0;

    await Future.forEach(provider.alldiagnostics, (currentQuestion) async {
      var selectedAnswer = currentQuestion['selectedAnswer'];
      final correctAnswer = currentQuestion['mcq'][0]['mcq_answers'];

      if (selectedAnswer != null && selectedAnswer is String) {
        final mcqOptions = currentQuestion['mcq'];
        for (int j = 0; j < mcqOptions.length; j++) {
          if (selectedAnswer == mcqOptions[j]['mcq_ans']) {
            selectedAnswer = String.fromCharCode(65 + j);
            currentQuestion['selectedAnswer'] = selectedAnswer;
            break;
          }
        }
      }

      if (selectedAnswer == null) {
        if (unansweredIndex == -1) {
          unansweredIndex = provider.alldiagnostics.indexOf(currentQuestion);
        }
        missedQuestions.add(provider.alldiagnostics.indexOf(currentQuestion));
      } else if (selectedAnswer == correctAnswer) {
        correctCount++;
      } else {
        wrongCount++;
        wrongQuestionIds.add(currentQuestion['id']);
      }
    });

    if (!mounted) return; // Ensure widget is still mounted

    if (unansweredIndex != -1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Unanswered Questions'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(missedQuestions.length, (index) {
                final int unansweredIndex = missedQuestions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text('Question ${unansweredIndex + 1} is missed '),
                      const SizedBox(width: 7),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: faceBookColor),
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            currentIndex = unansweredIndex;
                          });
                        },
                        child: const Text('View',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              }),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: faceBookColor),
                  onPressed: () {
                    int minutes = _seconds ~/ 60;
                    int seconds = _seconds % 60;
                    storeExamResults(
                        correctCount,
                        wrongCount,
                        minutes,
                        wrongQuestionIds,
                        provider.alldiagnostics.length,
                        score,
                        passscore);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Your answers are submitted')));
                    Future.delayed(const Duration(seconds: 2), () {
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiagnosticResultScreen(
                            wrongCount: wrongCount,
                            correctCount: correctCount,
                            totalQuestions: provider.alldiagnostics.length,
                            score: score,
                            passscore: passscore,
                            seconds: seconds,
                            wrongQuestionIds: wrongQuestionIds,
                            exid: provider.exid,
                          ),
                        ),
                      );
                    });
                  },
                  child:
                      const Text('OK', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          );
        },
      );
    } else {
      int minutes = _seconds ~/ 60;
      int seconds = _seconds % 60;
      storeExamResults(correctCount, wrongCount, minutes, wrongQuestionIds,
          provider.alldiagnostics.length, score, passscore);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your answers are submitted')));
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiagnosticResultScreen(
              wrongCount: wrongCount,
              correctCount: correctCount,
              totalQuestions: provider.alldiagnostics.length,
              score: score,
              passscore: passscore,
              seconds: seconds,
              wrongQuestionIds: wrongQuestionIds,
              exid: provider.exid,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final allDiagnostics =
        Provider.of<DiagExamProvider>(context).alldiagnostics;
    final currentQuestion = allDiagnostics[currentIndex];
    final minutes = _seconds ~/ 60;
    final seconds = _seconds % 60;
    final answeredCount = countAnsweredQuestions();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: faceBookColor,
            child: Row(
              children: [
                const Icon(Icons.timer, color: Colors.white),
                const SizedBox(width: 5),
                Text(
                  '$minutes:${seconds < 10 ? '0$seconds' : seconds}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(
                  width: 140,
                ),
                Text(
                  'Answered: $answeredCount/${allDiagnostics.length}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (currentQuestion['q_url'] != null)
                Image.network(currentQuestion['q_url'], height: 200),
              const SizedBox(height: 10),
              Text(
                'Question ${currentIndex + 1}: ${currentQuestion['question']}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                children: List.generate(currentQuestion['mcq'].length, (index) {
                  final mcq = currentQuestion['mcq'][index];
                  return RadioListTile<String>(
                    title: Text(' ${mcq['mcq_ans']}'),
                    value: mcq['mcq_ans'],
                    groupValue: currentQuestion[
                        'selectedAnswer'], // Set groupValue to null initially
                    onChanged: (String? value) {
                      setState(() {
                        currentQuestion['selectedAnswer'] = value;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (currentIndex > 0)
                    ElevatedButton(
                      onPressed: _prevQuestion,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: faceBookColor),
                      child: const Text('Previous',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ElevatedButton(
                    onPressed:
                        _showQuestionsDialog, // Show the dialog to navigate to any question
                    style: ElevatedButton.styleFrom(
                        backgroundColor: faceBookColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10)),
                    child: const Text('Go to Question',
                        style: TextStyle(color: Colors.white)),
                  ),
                  if (currentIndex < allDiagnostics.length - 1)
                    ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: faceBookColor),
                      child: const Text('Next',
                          style: TextStyle(color: Colors.white)),
                    ),
                  if (currentIndex == allDiagnostics.length - 1 ||
                      allDiagnostics.length == 1)
                    ElevatedButton(
                      onPressed: () {
                        _submitExam(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: faceBookColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5)),
                      child: const Text('Submit',
                          style: TextStyle(color: Colors.white)),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
