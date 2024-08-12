// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/history_models/questions_answers_model.dart';
import 'package:flutter_application_1/View/screens/history_screens/question_answer_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/question_history_controller.dart';
import 'package:provider/provider.dart';

class ParallelQuestionScreen extends StatefulWidget {
  const ParallelQuestionScreen(
      {super.key, required this.id, required this.selectedParallel});
  final int id;
  final int selectedParallel;

  @override
  State<ParallelQuestionScreen> createState() => _ParallelQuestionScreenState();
}

class _ParallelQuestionScreenState extends State<ParallelQuestionScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController answerController = TextEditingController();
  bool? textAnswer;

  @override
  void initState() {
    Provider.of<QuestionHistoryProvider>(context, listen: false)
        .getParallelQuestion(context, widget.id);
    super.initState();
  }

  bool answerSubmitted = false;
  String? selectedAnswer;
  int correctAnswerIndex = -1;

  Container _buildRadioListTile(Parallel parallel, int index) {
    String mcqText = parallel.mcqParallelList[index].text;
    String mcqValue =
        String.fromCharCode(index + 65); // Convert index to A, B, C, D
    Color? currentContainerColor;

    // Determine color based on answer selection and whether answer was submitted
    if (answerSubmitted) {
      currentContainerColor = index == correctAnswerIndex
          ? const Color.fromARGB(255, 133, 240, 137) // Correct answer
          : selectedAnswer == mcqValue
              ? const Color.fromARGB(255, 238, 104, 95) // Incorrect answer
              : null;
    }

    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: currentContainerColor,
      ),
      child: RadioListTile<String>(
        title: Text('$mcqValue.'), // Add the letter before the choice text
        value: mcqValue,
        groupValue: selectedAnswer,
        activeColor: Colors.redAccent[700],
        onChanged: answerSubmitted
            ? null // Disable onChanged when answer is submitted
            : (value) {
                setState(() {
                  selectedAnswer = value;
                });
              },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Parallel Question'),
      body: Consumer<QuestionHistoryProvider>(
        builder: (context, parallelProvider, _) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  // Text(
                  //   parallelProvider
                  //       .allParallelQuestions[widget.selectedParallel].question,
                  //   style: const TextStyle(fontSize: 25),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.network(
                      '${parallelProvider.allParallelQuestions[widget.selectedParallel].qUrl}'),
                  const SizedBox(
                    height: 20,
                  ),
                  if (parallelProvider
                      .allParallelQuestions[0].mcqParallelList.isNotEmpty)
                    for (int i = 0;
                        i <
                            parallelProvider
                                .allParallelQuestions[widget.selectedParallel]
                                .mcqParallelList
                                .length;
                        i++)
                      _buildRadioListTile(
                          parallelProvider
                              .allParallelQuestions[widget.selectedParallel],
                          i)
                  else
                    Form(
                      child: TextFormField(
                        key: formKey,
                        controller: answerController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your answer',
                        ),
                        onSaved: (newValue) {
                          setState(() {
                            selectedAnswer = newValue;
                          });
                        },
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                }
                      if (selectedAnswer != null && !answerSubmitted) {
                        if (parallelProvider.allParallelQuestions.isNotEmpty) {
                          String correctAnswer = parallelProvider
                                  .allParallelQuestions[0]
                                  .mcqParallelList
                                  .isNotEmpty
                              ? parallelProvider.allParallelQuestions[0]
                                  .mcqParallelList[0].answer
                              : ''; // You might want to handle this case based on your logic
                          correctAnswerIndex = correctAnswer.isNotEmpty
                              ? correctAnswer.codeUnitAt(0) - 65
                              : -1;
                          setState(() {
                            answerSubmitted = true;
                          });
                        } else {
                          // Handle case when allParallelQuestions is empty
                        }
                      } else if (parallelProvider.allParallelQuestions[0]
                              .mcqAnswerList[0].mcqParallelAnswer ==
                          answerController.text) {
                        setState(() {
                          textAnswer = true;
                        });
                      } else if (parallelProvider.allParallelQuestions[0]
                              .mcqAnswerList[0].mcqParallelAnswer !=
                          answerController.text) {
                        setState(() {
                          textAnswer = false;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an answer'),
                          ),
                        );
                      }
                      if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 60,
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  !answerSubmitted
                      ? const Text('')
                      : ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirmation"),
                                  content: const Text(
                                    "Are you sure you want to view the answer for this question?",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        log('Q ID : ${parallelProvider.allParallelQuestions[0].id}');
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    QuestionAnswerScreen(
                                                      id: parallelProvider
                                                          .allParallelQuestions[
                                                              0]
                                                          .id,
                                                    )));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.redAccent[700],
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.redAccent[700],
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('View Answer'),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
