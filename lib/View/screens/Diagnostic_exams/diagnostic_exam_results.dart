import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class DiagnosticExamResults extends StatefulWidget {
  const DiagnosticExamResults({super.key});

  @override
  State<DiagnosticExamResults> createState() => _DiagnosticExamResultsState();
}

class _DiagnosticExamResultsState extends State<DiagnosticExamResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diagnostic Exam Results"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: faceBookColor,
        ),
      ),
    );
  }
}
