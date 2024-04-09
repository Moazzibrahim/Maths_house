// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Timer_provider.dart';
import 'package:flutter_application_1/controller/exam_mcq_provider.dart';
import 'package:provider/provider.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam"),
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios),
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
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    fetchExamData();
  }

  Future<void> fetchExamData() async {
    final mcqprovider = Provider.of<ExamMcqProvider>(context, listen: false);
    final data = await mcqprovider.fetchExamDataFromApi(context);
    setState(() {
      questionsWithAnswers = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context, listen: false);

    if (questionsWithAnswers == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (questionsWithAnswers!.isEmpty) {
      return const Center(
        child: Text("No questions available"),
      );
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
                Column(
                  children: List.generate(
                    questionsWithAnswers![_questionIndex].mcqOptions.length,
                    (index) => RadioListTile(
                      title: Text(questionsWithAnswers![_questionIndex].mcqOptions[index]),
                      value: index,
                      groupValue: _selectedOptionIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedOptionIndex = value;
                        });
                      },
                    ),
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
                  timerProvider.stopTimer(); // Stop timer
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Answers submitted.'),
                    ),
                  );
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
}
