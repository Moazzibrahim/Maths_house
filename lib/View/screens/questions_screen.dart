import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/question_filter_model.dart';
import 'package:flutter_application_1/View/screens/history_screens/question_answer_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/question_provider.dart';
import 'package:provider/provider.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.month,
    required this.section,
    required this.year,
    required this.examCode,
    required this.questionNum,
  });

  final int month;
  final String section;
  final int year;
  final String examCode;
  final String questionNum;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  TextEditingController answerController = TextEditingController();
  bool? textAnswer;
  String? selectedAnswer;
  bool isRightAnswer = true;
  Color? containerColor;
  int correctAnswerIndex = -1; // Index of the correct answer
  bool answerSubmitted = false;
  bool showAnswerButton = false; // Flag to show the answer button

  @override
  void initState() {
    Provider.of<QuestionsProvider>(context, listen: false)
        .getQuestionsData(context);
    super.initState();
  }

  Container _buildRadioListTile(Question question, int index) {
    String mcqText = question.mcqList[index].text!;
    String mcqValue = String.fromCharCode(index + 65);
    Color? currentContainerColor;
    if (answerSubmitted) {
      currentContainerColor = index == correctAnswerIndex
          ? const Color.fromARGB(255, 133, 240, 137)
          : selectedAnswer == mcqValue
              ? const Color.fromARGB(255, 238, 104, 95)
              : null;
    }

    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: currentContainerColor,
      ),
      child: RadioListTile<String>(
        title: Text(mcqText),
        value: mcqValue,
        groupValue: selectedAnswer,
        activeColor: Colors.redAccent[700],
        onChanged: answerSubmitted
            ? null
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
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: gridHomeColor, borderRadius: BorderRadius.circular(12)),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.redAccent[700],
              )),
        ),
        title: const Text(
          'Questions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<QuestionsProvider>(
          builder: (context, questionsProvider, _) {
            if (questionsProvider.allQuestions.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Question> question = questionsProvider.allQuestions
                  .where((e) =>
                      e.examCode == widget.examCode &&
                      e.month == widget.month + 1 &&
                      e.questionNum == widget.questionNum &&
                      e.section == widget.section &&
                      e.year == widget.year)
                  .toList();
              if (question.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 80,
                        color: Colors.redAccent[700],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'No questions for this data',
                        style: TextStyle(
                            color: Colors.redAccent[700],
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Image.network(question[0].qUrl!),
                        const SizedBox(
                          height: 20,
                        ),
                        if (question[0].mcqList.isNotEmpty)
                          for (int i = 0; i < question[0].mcqList.length; i++)
                            _buildRadioListTile(question[0], i)
                        else
                          TextFormField(
                            controller: answerController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your answer',
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (selectedAnswer != null && !answerSubmitted) {
                              String correctAnswer =
                                  question[0].mcqList[0].answer!;
                              correctAnswerIndex =
                                  correctAnswer.codeUnitAt(0) - 65;

                              setState(() {
                                answerSubmitted = true;

                                if (selectedAnswer != correctAnswer) {
                                  showAnswerButton = true;
                                } else {
                                  showAnswerButton = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Correct Answer!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              });
                            } else if (question[0].mcqAnswerList[0].mcqAnswer ==
                                answerController.text) {
                              setState(() {
                                textAnswer = true;
                                showAnswerButton = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Correct Answer!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              });
                            } else if (question[0].mcqAnswerList[0].mcqAnswer !=
                                answerController.text) {
                              setState(() {
                                textAnswer = false;
                                showAnswerButton = true;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select an answer'),
                                ),
                              );
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
                        if (showAnswerButton)
                          ElevatedButton(
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
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      QuestionAnswerScreen(
                                                        id: question[0].qId!,
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
                              backgroundColor: Colors.greenAccent[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 60,
                              ),
                            ),
                            child: const Text(
                              'Show Answer',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
