import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/package_screen.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/exam_history_controller.dart';
import 'package:provider/provider.dart';

class ExamHistoryScreen extends StatefulWidget {
  const ExamHistoryScreen({super.key});

  @override
  State<ExamHistoryScreen> createState() => _ExamHistoryScreenState();
}

class _ExamHistoryScreenState extends State<ExamHistoryScreen> {
  @override
  void initState() {
    Provider.of<ExamHistoryProvider>(context,listen: false).getExamHistoryData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,'Exam History'),
      body: Consumer<ExamHistoryProvider>(builder: (context, examHistoryProvider, _) {
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
                          'Name',
                        ),
                        numeric: true, // Set to true for numeric data
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text(
                          'Score',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Actions',
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text(
                          'Recommendation',
                        ),
                        numeric: true,
                      ),
                    ],
                    rows: <DataRow>[
                      for (var e in examHistoryProvider.allExamHistory)
                        DataRow(
                          cells: [
                            DataCell(Text(e.examName)),
                            DataCell(Text(e.date)),
                            DataCell(Text(e.score.toString())),
                            DataCell(ElevatedButton(onPressed: () {
                              
                            },style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.redAccent[700],
                                  foregroundColor: Colors.white,
                                ),child: const Text('View mistake'),)),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx)=>const TabsScreen(isLoggedIn: false))
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
                                child: const Text('Recommendation'),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
              ],
            ),
          ) ,
        );
      },
      ),
    );
  }
}