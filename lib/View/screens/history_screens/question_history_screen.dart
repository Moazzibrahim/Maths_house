import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/history_screens/question_answer_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
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
    Provider.of<QuestionHistoryProvider>(context, listen: false)
        .getQuestionsHistoryData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,'Question History'),
      body: Consumer<QuestionHistoryProvider>(
        builder: (context, questionHistoryProvider, _) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  DataTable(
                    dataRowMaxHeight: 55,
                    columnSpacing:
                        25, // Adjust the spacing between columns here
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Year',
                        ),
                        numeric: true, // Set to true for numeric data
                      ),
                      DataColumn(
                        label: Text(
                          'Month',
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text(
                          'Section',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Answer',
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text(
                          'Actions',
                        ),
                        numeric: true,
                      ),
                    ],
                    rows: <DataRow>[
                      for (var e in questionHistoryProvider.allQuestionsHistory)
                        DataRow(
                          cells: [
                            DataCell(Text(e.year.toString())),
                            DataCell(Text(e.month.toString())),
                            DataCell(Text(e.section)),
                            DataCell(e.answer == 0
                                ? const Text('false')
                                : const Text('true')),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Confirmation"),
                                        content: const Text(
                                            "Are you sure you want to view the answer for this question?",style: TextStyle(fontSize: 18),),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              log('QQQQ ID: ${e.id}');
                                              Navigator.of(context).pop();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          QuestionAnswerScreen(
                                                            id: e.id,
                                                          )));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.redAccent[700],
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                                            ),
                                            child: const Text('Yes'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Close',style: TextStyle(color: Colors.black),),
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
                            ),
                          ],
                        ),
                    ],
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
