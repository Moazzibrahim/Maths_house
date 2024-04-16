import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/diagnostic_exams/diagnostic_exam_model.dart';
import 'package:flutter_application_1/constants/colors.dart';
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
    final diagProvider = Provider.of<DiagExamProvider>(context);
    final questionData = diagProvider.alldiagnostics.isNotEmpty
        ? diagProvider.alldiagnostics[_currentQuestionIndex]
        : QuestionData(
            courseId: 0,
            question: '',
            qNum: '',
            qType: '',
            mcq: null,
            gAns: null,
          );

    void goToNextQuestion() {
      if (_currentQuestionIndex < diagProvider.alldiagnostics.length - 1) {
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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question: ${questionData.question}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          if (questionData.qType == 'MCQ' && questionData.mcq != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: questionData.mcq!.map<Widget>((mcq) {
                return Row(
                  children: [
                    Radio(
                      value: mcq.mcqAns,
                      groupValue: null,
                      onChanged: null,
                    ),
                    Text(mcq.mcqAnswers),
                  ],
                );
              }).toList(),
            )
          else
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your answer...',
                border: OutlineInputBorder(),
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: goToPreviousQuestion,
                child: const Text('Previous'),
              ),
              ElevatedButton(
                onPressed: goToNextQuestion,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
