import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/Diagnostic_exams/diagnostic_result_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Timer_provider.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_exam_provider.dart';
import 'package:provider/provider.dart';

class StartDiagnostic extends StatelessWidget {
  const StartDiagnostic({super.key});

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
  const DiagnosticBody({super.key});

  @override
  State<DiagnosticBody> createState() => _DiagnosticBodyState();
}

class _DiagnosticBodyState extends State<DiagnosticBody> {
  int _currentQuestionIndex = 0;

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

    void submitAnswers() {
      // Logic to submit answers goes here
      timerProvider.stopTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your answers are submitted')),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DiagnosticResultScreen(),
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
                      children:
                          (questionData['mcq'] as List).map<Widget>((mcq) {
                        return Row(
                          children: [
                            Radio(
                              value: mcq['mcq_ans'],
                              groupValue:
                                  selectedAnswers[_currentQuestionIndex],
                              onChanged: (value) {
                                setState(() {
                                  selectedAnswers[_currentQuestionIndex] =
                                      value.toString();
                                });
                              },
                              activeColor:
                                  selectedAnswers[_currentQuestionIndex] ==
                                          mcq['mcq_ans']
                                      ? Colors.green
                                      : Colors.red,
                            ),
                            Text(mcq['mcq_answers']),
                          ],
                        );
                      }).toList(),
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
