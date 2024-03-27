import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Timer_provider.dart';
import 'package:provider/provider.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Exam"),
        ),
        body: const ExamBody(),
      ),
    );
  }
}

class ExamBody extends StatefulWidget {
  const ExamBody({Key? key}) : super(key: key);

  @override
  _ExamBodyState createState() => _ExamBodyState();
}

class _ExamBodyState extends State<ExamBody> {
  int _questionIndex = 0;
  bool _isSubmitting = false;
  List<String> questions = [
    "What is the capital of France?",
    "Who wrote 'Romeo and Juliet'?",
    "What is the powerhouse of the cell?"
  ];
  List<List<String>> options = [
    ["Paris", "Berlin", "London", "Madrid"],
    ["William Shakespeare", "Charles Dickens", "Jane Austen", "Mark Twain"],
    ["Mitochondria", "Nucleus", "Ribosome", "Endoplasmic Reticulum"]
  ];
  List<int> answers = [0, 0, 0]; // Index of correct answer for each question

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.blue,
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
                  "Question ${_questionIndex + 1}: ${questions[_questionIndex]}",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Column(
                  children: List.generate(
                    options[_questionIndex].length,
                    (index) => RadioListTile(
                      title: Text(options[_questionIndex][index]),
                      value: index,
                      groupValue: answers[_questionIndex],
                      onChanged: (value) {
                        setState(() {
                          answers[_questionIndex] = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _isSubmitting
            ? ElevatedButton(
                onPressed: () {
                  // Handle submit action here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Answers submitted.'),
                    ),
                  );
                },
                child: Text('Submit'),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _questionIndex > 0 ? goToPreviousQuestion : null,
                    child: const Text("Previous"),
                  ),
                  ElevatedButton(
                    onPressed: _questionIndex < questions.length - 1
                        ? goToNextQuestion
                        : () {
                            setState(() {
                              _isSubmitting = true;
                            });
                          },
                    child: const Text("Next"),
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
}
