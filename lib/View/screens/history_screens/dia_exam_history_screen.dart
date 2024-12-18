// ignore_for_file: avoid_print, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_duration.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/dia_exam_history_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DiaExamHistoryScreen extends StatefulWidget {
  const DiaExamHistoryScreen({super.key});

  @override
  State<DiaExamHistoryScreen> createState() => _DiaExamHistoryScreenState();
}

class _DiaExamHistoryScreenState extends State<DiaExamHistoryScreen> {
  @override
  void initState() {
    Provider.of<DiaExamHistoryProvider>(context, listen: false)
        .getDiaExamHistory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Diagnostic History"),
      body: Consumer<DiaExamHistoryProvider>(
        builder: (context, diaExamHistory, _) {
          void showChapterDialog(
              BuildContext context, List<String> chapterNames) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Recommended Chapters'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: chapterNames.map((chapter) {
                        return Column(
                          children: [
                            Text(chapter),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: faceBookColor),
                              onPressed: () {
                                // Handle buy button pressed
                                print('Buy $chapter');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ExamDuration(
                                        chapterNames:
                                            diaExamHistory.chapterName,
                                        ids: diaExamHistory.idddddd,
                                        prices: diaExamHistory.pricess,
                                        durations: diaExamHistory.durations,
                                        discounts: diaExamHistory.discounts)));
                              },
                              child: const Text(
                                'Buy',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  DataTable(
                    dataRowMaxHeight: 55.h,
                    columnSpacing: 25,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Name',
                        ),
                        numeric: true,
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
                          'Recommendation',
                        ),
                        numeric: true,
                      ),
                    ],
                    rows: <DataRow>[
                      for (var e in diaExamHistory.allDiaExam)
                        DataRow(
                          cells: [
                            DataCell(Text(e.examTitle)),
                            DataCell(Text(e.date)),
                            DataCell(Text(e.score.toString())),
                            DataCell(
                              ElevatedButton(
                                onPressed: () async {
                                  await diaExamHistory
                                      .getDiaExamHistoryrecommendation(
                                          context, e.id);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => ExamDuration(
                                          chapterNames:
                                              diaExamHistory.chapterName,
                                          ids: diaExamHistory.idddddd,
                                          prices: diaExamHistory.pricess,
                                          durations: diaExamHistory.durations,
                                          discounts:
                                              diaExamHistory.discounts)));
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
            ),
          );
        },
      ),
    );
  }
}
