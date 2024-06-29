// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/history_screens/exam_options_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/exam_recommendation_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/exam_history_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExamHistoryScreen extends StatefulWidget {
  const ExamHistoryScreen({super.key});

  @override
  State<ExamHistoryScreen> createState() => _ExamHistoryScreenState();
}

class _ExamHistoryScreenState extends State<ExamHistoryScreen> {
  @override
  void initState() {
    Provider.of<ExamHistoryProvider>(context, listen: false)
        .getExamHistoryData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Exam History'),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Consumer<ExamHistoryProvider>(
          builder: (context, examHistoryProvider, _) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  dataRowHeight: 60.h,
                  columnSpacing: 25.w,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Name',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text(
                        'Score',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Actions',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text(
                        'Recommendation',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      numeric: true,
                    ),
                  ],
                  rows: examHistoryProvider.allExamHistory
                      .map(
                        (e) => DataRow(
                          cells: [
                            DataCell(Text(e.examName,
                                style: TextStyle(fontSize: 14.sp))),
                            DataCell(Text(e.date,
                                style: TextStyle(fontSize: 14.sp))),
                            DataCell(Text(e.score.toString(),
                                style: TextStyle(fontSize: 14.sp))),
                            DataCell(
                              ElevatedButton(
                                onPressed: () async{
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (ctx)=> ExamOptionScreen(id: e.id,))
                                      );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7.h, horizontal: 5.w),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  backgroundColor: Colors.redAccent[700],
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('View Mistake'),
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ExamRecommendationScreen(id: e.id)));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7.h, horizontal: 5.w),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  backgroundColor: Colors.redAccent[700],
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Recommendation'),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
