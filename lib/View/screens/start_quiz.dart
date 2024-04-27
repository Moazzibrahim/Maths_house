import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/quizzes_model.dart';
import 'dart:async';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartQuiz extends StatefulWidget {
  const StartQuiz({super.key, required this.quiz});
  final QuizzesModel quiz;

  @override
  State<StartQuiz> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  late Timer _timer;
  int _secondsElapsed = 0;
  int currentQuestionIndex = 0;
  List<String?> selectedAnswers=[];
  List<QuestionsQuiz> correctAnswers = [];
  List<QuestionsQuiz> wrongAnswers = [];

  @override
  void initState() {
    selectedAnswers = List.generate(widget.quiz.questionQuizList.length, (index) => null);
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < widget.quiz.questionQuizList.length - 1) {
        currentQuestionIndex++;
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  String? getSelectedAnswer() {
    return selectedAnswers[currentQuestionIndex];
  }

  void updateSelectedAnswer(String? value) {
    setState(() {
      selectedAnswers[currentQuestionIndex] = value;
    });
  }

  RadioListTile buildRadioListTile(QuestionsQuiz questionsQuiz, int i) {
    String mcqChoice = questionsQuiz.mcqQuizList[i].choice;
    String mcqValue = String.fromCharCode(i + 65);

    return RadioListTile(
        title: Text(mcqChoice),
        value: mcqValue,
        groupValue: getSelectedAnswer(),
        onChanged: (value) {
          setState(() {
            updateSelectedAnswer(value);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    QuestionsQuiz currentQuestion =
        widget.quiz.questionQuizList[currentQuestionIndex];
    return Scaffold(
      appBar: buildAppBar(context, 'Quiz'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: gridHomeColor,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.timer_outlined),
                          const SizedBox(width: 8),
                          Text(_formatTime(_secondsElapsed)),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  currentQuestion.question,
                  style: const TextStyle(fontSize: 20),
                ),
                for (int i = 0; i < currentQuestion.mcqQuizList.length; i++)
                  buildRadioListTile(currentQuestion, i),
              ],
            ),
            Positioned(
              bottom: 20,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: previousQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent[700],
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Previous'),
                  ),
                  SizedBox(
                    width: 55.w,
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: const Text('Go to Question'),
                              children: List.generate(
                                widget.quiz.questionQuizList.length,
                                (index) => SimpleDialogOption(
                                  onPressed: () {
                                    setState(() {
                                      currentQuestionIndex = index;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text("Question ${index + 1}"),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text('Question ${currentQuestionIndex + 1}')),
                  SizedBox(
                    width: 55.w,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (currentQuestionIndex !=
                            widget.quiz.questionQuizList.length - 1) {
                          if (selectedAnswers[currentQuestionIndex] != null) {
                            if (selectedAnswers[currentQuestionIndex] ==
                                currentQuestion.mcqQuizList[0].answer) {
                              correctAnswers.add(currentQuestion);
                              log('correct added');
                              nextQuestion();
                            } else {
                              wrongAnswers.add(currentQuestion);
                              log('wrong added');
                              nextQuestion();
                            }
                          } else {
                            nextQuestion();
                          }
                        } else {
                          if (selectedAnswers[currentQuestionIndex] != null) {
                            if (selectedAnswers[currentQuestionIndex] ==
                                currentQuestion.mcqQuizList[0].answer) {
                              correctAnswers.add(currentQuestion);
                            } else {
                              wrongAnswers.add(currentQuestion);
                            }
                          }
                          log('correct q: $correctAnswers');
                          log('wrong q: $wrongAnswers');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent[700],
                          foregroundColor: Colors.white),
                      child: currentQuestionIndex ==
                              widget.quiz.questionQuizList.length - 1
                          ? const Text('Submit')
                          : const Text('Next')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
