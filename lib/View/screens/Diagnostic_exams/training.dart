// ignore_for_file: avoid_print

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

// ignore: must_be_immutable
class DiagnosticQuestionsList extends StatefulWidget with ChangeNotifier {
  final int exid;
  final int score;
  DiagnosticQuestionsList({super.key, required this.exid, required this.score});

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
    setState(() {
      if (currentIndex <
          Provider.of<DiagExamProvider>(context, listen: false)
                  .alldiagnostics
                  .length -
              1) {
        currentIndex++;
      }
    });
  }

  void _prevQuestion() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  void _showQuestionsDialog() {
    final allDiagnostics =
        Provider.of<DiagExamProvider>(context, listen: false).alldiagnostics;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Go to Question'),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(allDiagnostics.length, (index) {
                final question = allDiagnostics[index];
                return ListTile(
                  title: Text('Question ${index + 1}: ${question['question']}'),
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
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
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

  int correctCount = 0;
  int wrongCount = 0;

  void _submitExam(BuildContext context) {
    _timer.cancel(); // Stop the timer
    // Calculate correct and wrong answer counts
    final provider = Provider.of<DiagExamProvider>(context, listen: false);
    int unansweredIndex = -1;
    List<int> wrongQuestionIds = [];
    final int score =
        Provider.of<DiagExamProvider>(context, listen: false).score;
    final int passscore =
        Provider.of<DiagExamProvider>(context, listen: false).passscore;

    for (int i = 0; i < provider.alldiagnostics.length; i++) {
      final currentQuestion = provider.alldiagnostics[i];
      var selectedAnswer = currentQuestion['selectedAnswer'];
      final correctAnswer = currentQuestion['mcq'][0]['mcq_answers'];

      // Convert selected answer to letter if it's not already converted
      if (selectedAnswer != null && selectedAnswer is String) {
        final mcqOptions = currentQuestion['mcq'];
        for (int j = 0; j < mcqOptions.length; j++) {
          if (selectedAnswer == mcqOptions[j]['mcq_ans']) {
            selectedAnswer = String.fromCharCode(
                65 + j); // Convert index to letter (A, B, C, ...)
            currentQuestion['selectedAnswer'] = selectedAnswer;
            break;
          }
        }
      }

      if (selectedAnswer == null) {
        unansweredIndex = i;
        missedQuestions.add(i);
        break;
      }
      if (selectedAnswer == correctAnswer) {
        correctCount++;
      } else {
        wrongCount++;
        wrongQuestionIds
            .add(currentQuestion['id']); // Add the ID of wrong question
      }
      print('Question ${i + 1}:');
      print('Selected Answer: $selectedAnswer');
      print('Correct Answer: $correctAnswer');
    }
    if (unansweredIndex != -1) {
      // Show an alert dialog for unanswered question
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Unanswered Questions'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                missedQuestions.length,
                (index) {
                  final int unansweredIndex = missedQuestions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Text('Question ${unansweredIndex + 1} is missed '),
                        const SizedBox(width: 7),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: faceBookColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                            setState(() {
                              currentIndex =
                                  unansweredIndex; // Navigate to the unanswered question
                            });
                          },
                          child: const Text(
                            'View',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: faceBookColor,
                  ),
                  onPressed: () {
                    int minutes = _seconds ~/ 60;
                    // ignore: unused_local_variable
                    int seconds = _seconds % 60;
                    storeExamResults(
                      correctCount,
                      wrongCount,
                      minutes,
                      wrongQuestionIds,
                      Provider.of<DiagExamProvider>(context, listen: false)
                          .alldiagnostics
                          .length,
                      Provider.of<DiagExamProvider>(context, listen: false)
                          .score,
                      Provider.of<DiagExamProvider>(context, listen: false)
                          .passscore,
                    );
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Your answers are submitted'),
                          ),
                        );
                      },
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiagnosticResultScreen(
                            wrongCount: wrongCount,
                            correctCount: correctCount,
                            totalQuestions: Provider.of<DiagExamProvider>(
                                    context,
                                    listen: false)
                                .alldiagnostics
                                .length,
                            score: score,
                            passscore: passscore,
                            seconds: seconds,
                            wrongQuestionIds: wrongQuestionIds,
                          ),
                        ),
                      );
                    }); // Close the dialog
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
    } else {
      // All questions answered, show result
      int minutes = _seconds ~/ 60;
      // ignore: unused_local_variable
      int seconds = _seconds % 60;
      storeExamResults(
        correctCount,
        wrongCount,
        minutes,
        wrongQuestionIds,
        Provider.of<DiagExamProvider>(context, listen: false)
            .alldiagnostics
            .length,
        Provider.of<DiagExamProvider>(context, listen: false).score,
        Provider.of<DiagExamProvider>(context, listen: false).passscore,
      );
      Future.delayed(
        const Duration(seconds: 1),
        () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Your answers are submitted')),
          );
        },
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DiagnosticResultScreen(
                      wrongCount: wrongCount,
                      correctCount: correctCount,
                      totalQuestions:
                          Provider.of<DiagExamProvider>(context, listen: false)
                              .alldiagnostics
                              .length,
                      score: score,
                      passscore: passscore,
                      seconds: seconds,
                      wrongQuestionIds: wrongQuestionIds,
                    )));
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          color: faceBookColor,
          child: Row(
            children: [
              const Icon(Icons.timer, color: Colors.white),
              const SizedBox(
                width: 5,
              ),
              Text(
                '$minutes:${seconds < 10 ? '0$seconds' : seconds}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (currentQuestion['q_url'] != null)
            //   Image.network(currentQuestion['q_url'], height: 200),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Question ${currentIndex + 1}: ${currentQuestion['question']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // if (currentQuestion['ans_type'] != 'MCQ')
            //   TextFormField(
            //     decoration:
            //         const InputDecoration(labelText: 'Type your answer here'),
            //     onChanged: (value) {
            //       currentQuestion['selectedAnswer'] = value;
            //     },
            //   ),
          ],
        ),
        // if (currentQuestion['ans_type'] == 'MCQ')
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
                  backgroundColor: faceBookColor,
                ),
                child: const Text(
                  'Previous',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ElevatedButton(
              onPressed:
                  _showQuestionsDialog, // Show the dialog to navigate to any question
              style: ElevatedButton.styleFrom(
                backgroundColor: faceBookColor,
              ),
              child: const Text(
                'Go to Question',
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (currentIndex < allDiagnostics.length - 1)
              ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: faceBookColor,
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            if (currentIndex == allDiagnostics.length - 1 ||
                allDiagnostics.length == 1)
              ElevatedButton(
                onPressed: () async {
                  _submitExam(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
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
}


    // void postDiagExamResults(int correctAnswerCount, Duration? elapsedTime,
    //     List<int> wrongQuestionIds) async {
    //   const url =
    //       'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_dia_exam_grade';
    //   final startExamProvider =
    //       Provider.of<DiagExamProvider>(context, listen: false);
    //   final examId = startExamProvider.exid;

    //   // Check if elapsedTime is null, if so, initialize it to Duration.zero
    //   elapsedTime ??= Duration.zero;
    //   // Calculate elapsed time in minutes and seconds as a combined string
    //   final String elapsed =
    //       '${elapsedTime.inMinutes}:${(elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}';
    //   final int elapsedMinutes = elapsedTime.inMinutes;
    //   final int elapsedSeconds = elapsedTime.inSeconds % 60;

    //   final Map<String, dynamic> postData = {
    //     'exam_id': examId,
    //     'right_question': correctAnswerCount,
    //     'timer': elapsedMinutes,
    //     'mistakes': wrongQuestionIds,
    //   };

    //   final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    //   final token = tokenProvider.token; // Replace with your auth token

    //   try {
    //     final response = await http.post(
    //       Uri.parse(url),
    //       headers: {
    //         'Content-Type': 'application/json',
    //         'Accept': 'application/json',
    //         'Authorization': 'Bearer $token',
    //       },
    //       body: json.encode(postData),
    //     );

    //     if (response.statusCode == 200) {
    //       print(' Diag Exam results posted successfully.');
    //       print("exam id: $examId");
    //     } else {
    //       print('Failed to post exam results: ${response.statusCode}');
    //       // Print response body for more details
    //       print('Response body: ${response.body}');
    //     }
    //   } catch (e) {
    //     print('Error posting exam results: $e');
    //   }
    // }
