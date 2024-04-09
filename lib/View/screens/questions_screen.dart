

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/question_filter_model.dart';
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
  String? selectedAnswer;

  @override
  void initState() {
    Provider.of<QuestionsProvider>(context, listen: false)
        .getQuestionsData(context);
    super.initState();
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
        title: const Text('Question number 1'),
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
              List<Question> question = questionsProvider.allQuestions.where((e) =>
                  e.examCode == widget.examCode &&
                  e.month == widget.month+1 &&
                  e.questionNum == widget.questionNum &&
                  e.section == widget.section &&
                  e.year == widget.year
                  ).toList();
                  if(question.isEmpty){
                    return const Center(child: Text('No questions for this data '));
                  }else{
                    return Center(
                child: Column(
                  children: [
                    Text(
                      question[0].question,
                      style: const TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset('assets/images/planet.png'),
                    const SizedBox(
                      height: 20,
                    ),
                    RadioListTile<String>(
                      title: Text(question[0].mcqList[0].text),
                      value: 'A',
                      groupValue: selectedAnswer,
                      activeColor: Colors.redAccent[700],
                      onChanged: (value) {
                        setState(() {
                          selectedAnswer = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(question[0].mcqList[1].text),
                      value: 'B',
                      groupValue: selectedAnswer,
                      activeColor: Colors.redAccent[700],
                      onChanged: (value) {
                        setState(() {
                          selectedAnswer = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(question[0].mcqList[2].text),
                      value: 'C',
                      groupValue: selectedAnswer,
                      activeColor: Colors.redAccent[700],
                      onChanged: (value) {
                        setState(() {
                          selectedAnswer = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(question[0].mcqList[3].text),
                      value: 'D',
                      groupValue: selectedAnswer,
                      activeColor: Colors.redAccent[700],
                      onChanged: (value) {
                        setState(() {
                          selectedAnswer = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String correctAnswer = question[0].mcqList[0].answer;
                        if(correctAnswer == selectedAnswer){
                          log('answer is correct');
                        }
                        else{
                          log('you chose the wrong answer');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 60,
                          )),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
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
