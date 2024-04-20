import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/history_models/questions_answers_model.dart';
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
        title: Text(mcqText),
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
                  Text(
                    parallelProvider.allParallelQuestions[widget.selectedParallel].question,
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset('assets/images/planet.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  if(parallelProvider.allParallelQuestions[0].mcqParallelList.isNotEmpty)
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
                        i),
                        ElevatedButton(
                          onPressed: () {
                            if (selectedAnswer != null && !answerSubmitted) {
                              String correctAnswer =
                                  parallelProvider.allParallelQuestions[0].mcqParallelList[0].answer;
                              correctAnswerIndex =
                                  correctAnswer.codeUnitAt(0) - 65;
                              setState(() {
                                answerSubmitted = true;
                              });
                            }else if(parallelProvider.allParallelQuestions[0].mcqAnswerList[0].mcqParallelAnswer == answerController.text){
                              setState(() {
                                textAnswer = true;
                              });
                            }else if(parallelProvider.allParallelQuestions[0].mcqAnswerList[0].mcqParallelAnswer != answerController.text){
                              setState(() {
                                textAnswer = false;
                              });
                            }
                            else {
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
                        const SizedBox(height: 20,),
                        if(textAnswer == null)
                          const Text('')
                        else if(textAnswer!)
                          Text('Correct Answer',style: TextStyle(color: Colors.greenAccent[700],fontSize: 20),)
                        else
                          Text('Wrong answer',style: TextStyle(color: Colors.redAccent[700],fontSize: 20),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
