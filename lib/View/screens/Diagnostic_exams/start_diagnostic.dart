import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/diagnostic_exams/diagnostic_exam_model.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/Timer_provider.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_exam_provider.dart';
import 'package:provider/provider.dart';

class StartDiagnostic extends StatefulWidget {
  const StartDiagnostic({super.key});

  @override
  State<StartDiagnostic> createState() => _StartDiagnosticState();
}

class _StartDiagnosticState extends State<StartDiagnostic> {
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
            )),
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
  late final QuestionData questionData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final diagprov = Provider.of<DiagExamProvider>(context, listen: false)
        .fetchDataFromApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${questionData.qNum}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question: ${questionData.question}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (questionData.qType == 'MCQ')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: questionData.mcq != null
                    ? questionData.mcq!.map((mcq) {
                        return Row(
                          children: [
                            Radio(
                              value: mcq.mcqAns,
                              groupValue:
                                  null, // Provide a value here for groupValue
                              onChanged:
                                  null, // Provide a function here for onChanged
                            ),
                            Text(mcq.mcqAnswers),
                          ],
                        );
                      }).toList()
                    : [],
              )
            else
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your answer...',
                  border: OutlineInputBorder(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
