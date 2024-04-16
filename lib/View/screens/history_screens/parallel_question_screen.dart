import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/history_controllers/question_history_controller.dart';
import 'package:provider/provider.dart';

class ParallelQuestionScreen extends StatefulWidget {
  const ParallelQuestionScreen({super.key, required this.id});
  final int id;

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
          return Text('data');
        },
      ),
    );
  }
}
