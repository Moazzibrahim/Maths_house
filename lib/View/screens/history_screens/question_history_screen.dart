import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/history_controllers/question_history_controller.dart';
import 'package:provider/provider.dart';

class QuestionHistoryScreen extends StatefulWidget {
  const QuestionHistoryScreen({super.key});

  @override
  State<QuestionHistoryScreen> createState() => _QuestionHistoryScreenState();
}

class _QuestionHistoryScreenState extends State<QuestionHistoryScreen> {

  @override
  void initState() {
    Provider.of<QuestionHistoryProvider>(context,listen: false).getQuestionsHistoryData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Questions History',
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
              )),
        ),
      ),
      body: Consumer<QuestionHistoryProvider>(
        builder:(context, questionHistoryProvider, _) {
          return Center(child: Text('data'));
        },
        ),
    );
  }
}