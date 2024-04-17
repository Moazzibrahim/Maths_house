import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/history_models/questions_answers_model.dart';
import 'package:flutter_application_1/constants/colors.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Parallel Questions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
            ),
          ),
        ),
      ),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
