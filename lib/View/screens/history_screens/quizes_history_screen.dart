
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/quiz_history_controller.dart';
import 'package:provider/provider.dart';

class QuizesHistoryScreen extends StatefulWidget {
  const QuizesHistoryScreen({super.key});

  @override
  State<QuizesHistoryScreen> createState() => _QuizesHistoryScreenState();
}

class _QuizesHistoryScreenState extends State<QuizesHistoryScreen> {
  @override
  void initState() {
    Provider.of<QuizHistoryProvider>(context).getQuizHistory(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,'Quizes History'),
      body: Consumer<QuizHistoryProvider>(builder: (context, quizHistoryProvider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                      for (var e in quizHistoryProvider.allQuizHistory)
                        DataRow(
                          cells: [
                            DataCell(Text(e.quizName.toString())),
                            DataCell(Text(e.lessonName.toString())),
                            DataCell(Text(e.date)),
                            DataCell(Text(e.score.toString())),
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
      },) ,
    );
  }
}