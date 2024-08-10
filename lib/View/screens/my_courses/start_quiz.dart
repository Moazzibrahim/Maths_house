import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/quizzes_model.dart';
import 'package:flutter_application_1/View/screens/my_courses/quiz_score_screen.dart';
import 'dart:async';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/quiz_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StartQuiz extends StatefulWidget {
  const StartQuiz({super.key, required this.quiz});
  final QuizzesModel quiz;

  @override
  State<StartQuiz> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  late Timer _timer;
  TextEditingController ansText = TextEditingController();
  Set<int> indexOfUnsolvedQuestions = {};
  int _secondsElapsed = 0;
  int currentQuestionIndex = 0;
  List<TextEditingController> textControllers = [];
  List<String?> selectedAnswers = [];
  Set<QuestionsQuiz> correctAnswers = {};
  Set<int> wrongAnswers = {};
  Set<int> missedQuestions = {};

  @override
  void initState() {
    selectedAnswers =
        List.generate(widget.quiz.questionQuizList.length, (index) => null);
        for (var question in widget.quiz.questionQuizList) {
      if (question.mcqQuizList.isEmpty) {
        textControllers.add(TextEditingController());
      } else {
        textControllers.add(TextEditingController()); 
      }
    }
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
    String mcqChoice = questionsQuiz.mcqQuizList[i].mcqNum!;
    String mcqValue = String.fromCharCode(i + 65);

    return RadioListTile(
        activeColor: Colors.redAccent[700],
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
    QuestionsQuiz currentQuestion = widget.quiz.questionQuizList[currentQuestionIndex];
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
                Image.network(currentQuestion.qUrl),
                if (currentQuestion.mcqQuizList.isNotEmpty)
                  for (int i = 0; i < currentQuestion.mcqQuizList.length; i++)
                    buildRadioListTile(currentQuestion, i)
                else
                  TextFormField(
                    controller: textControllers[currentQuestionIndex],
                  )
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
                    width: 50.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (selectedAnswers[currentQuestionIndex] != null) {
                        if(missedQuestions.contains(currentQuestion.questionId)){
                          missedQuestions.remove(currentQuestion.questionId);
                        }
                        if (selectedAnswers[currentQuestionIndex] == currentQuestion.mcqQuizList[0].answer) {
                          if (wrongAnswers.contains(currentQuestion.questionId)) {
                            wrongAnswers.remove(currentQuestion.questionId);
                            log('wrong answer removed');
                          }
                          correctAnswers.add(currentQuestion);
                          log('correct added : ${correctAnswers.length}');
                        } else {
                          if (correctAnswers.contains(currentQuestion)) {
                            correctAnswers.remove(currentQuestion);
                            log('correct answer removed');
                          }
                          wrongAnswers.add(currentQuestion.questionId);
                          log('wrong added : ${wrongAnswers.length}');
                        }
                      }else{
                        missedQuestions.add(currentQuestion.questionId);
                            log('missed added');
                      }
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: const Text('Go to Question'),
                            children: List.generate(
                              widget.quiz.questionQuizList.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Question ${index + 1}'),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            currentQuestionIndex = index;
                                          });
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.redAccent[700],
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12))),
                                        child: const Text('View Question')),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'Question ${currentQuestionIndex + 1}',
                      style: TextStyle(
                          fontSize: 14.sp, color: Colors.redAccent[700]),
                    ),
                  ),
                  SizedBox(
                    width: 45.w,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (currentQuestionIndex != widget.quiz.questionQuizList.length - 1) {
                          if (selectedAnswers[currentQuestionIndex] != null) {
                            if(missedQuestions.contains(currentQuestion.questionId)){
                          missedQuestions.remove(currentQuestion.questionId);
                        }
                            if (selectedAnswers[currentQuestionIndex] == currentQuestion.mcqQuizList[0].answer) {
                              if (wrongAnswers.contains(currentQuestion.questionId)) {
                                wrongAnswers.remove(currentQuestion.questionId);
                                log('wrong answer removed');
                              }
                              correctAnswers.add(currentQuestion);
                              log('correct added : ${correctAnswers.length}');
                              nextQuestion();
                            } else {
                              if (correctAnswers.contains(currentQuestion)) {
                                correctAnswers.remove(currentQuestion);
                              }
                              wrongAnswers.add(currentQuestion.questionId);
                              log('wrong added : ${wrongAnswers.length}');
                              nextQuestion();
                            }
                          } else {
                            missedQuestions.add(currentQuestion.questionId);
                            log('missed added');
                            nextQuestion();
                          }
                        } else {
                          if (selectedAnswers[currentQuestionIndex] != null) {
                            if(missedQuestions.contains(currentQuestion.questionId)){
                          missedQuestions.remove(currentQuestion.questionId);
                        }
                            if (selectedAnswers[currentQuestionIndex] == currentQuestion.mcqQuizList[0].answer) {
                              correctAnswers.add(currentQuestion);
                              log('correct added : ${correctAnswers.length}');
                            } else {
                              wrongAnswers.add(currentQuestion.questionId);
                              log('wrong added : ${wrongAnswers.length}');
                            }
                          } else {
                            missedQuestions.add(currentQuestion.questionId);
                          }
                          if (selectedAnswers.contains(null)) {
                            for (int i = 0; i < selectedAnswers.length; i++) {
                              if (selectedAnswers[i] == null) {
                                setState(() {
                                  indexOfUnsolvedQuestions.add(i + 1);
                                });
                              }
                            }
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Submit Quiz'),
                                  content: Text(
                                      'you have not answered q.num: ${indexOfUnsolvedQuestions.map((e) => e,)}, are you sure you want to submit?'),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Provider.of<QuizzesProvider>(context, listen: false).postQuizData(context,
                              quizId: widget.quiz.id,
                              rightQuestion: correctAnswers.length,
                              timer: _secondsElapsed / 60.ceil(),
                              score: correctAnswers.length,
                              mistakes: wrongAnswers.toList() +
                                  missedQuestions.toList(),
                            );
                                          Navigator.pop(context);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      QuizScoreScreen(
                                                        quiz: widget.quiz,
                                                        correctAnswers:
                                                            correctAnswers,
                                                        wrongAnswers:
                                                            wrongAnswers,
                                                        missedQuestionsNumber:
                                                            missedQuestions
                                                                .length,
                                                      )));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.redAccent[700],
                                            foregroundColor: Colors.white),
                                        child: const Text('Yes')),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.redAccent[700],
                                            foregroundColor: Colors.white),
                                        child: const Text('No')),
                                  ],
                                );
                              },
                            );
                          } else {
                            Provider.of<QuizzesProvider>(context, listen: false)
                                .postQuizData(
                              context,
                              quizId: widget.quiz.id,
                              rightQuestion: correctAnswers.length,
                              timer: _secondsElapsed / 60.ceil(),
                              score: correctAnswers.length,
                              mistakes: wrongAnswers.toList() +
                                  missedQuestions.toList(),
                            );
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (ctx) => QuizScoreScreen(
                                          quiz: widget.quiz,
                                          correctAnswers: correctAnswers,
                                          wrongAnswers: wrongAnswers,
                                          missedQuestionsNumber:
                                              missedQuestions.length,
                                        )));
                          }
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
