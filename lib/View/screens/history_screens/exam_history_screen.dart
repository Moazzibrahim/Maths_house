// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/exam_answer_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/exam_parallel_questions.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/exam_history_controller.dart';
import 'package:flutter_application_1/controller/history_controllers/question_history_controller.dart';
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
            final allmistakes = examHistoryProvider.allmistakes;
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
                            DataCell(Text(e.examName, style: TextStyle(fontSize: 14.sp))),
                            DataCell(Text(e.date, style: TextStyle(fontSize: 14.sp))),
                            DataCell(Text(e.score.toString(), style: TextStyle(fontSize: 14.sp))),
                            DataCell(
                              ElevatedButton(
                                onPressed: () async {
                                  log('${e.id}');
                                  await Provider.of<ExamHistoryProvider>(context, listen: false)
                                      .getExamViewMistakesData(context, e.id);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      if (allmistakes.isEmpty) {
                                        return const Center(child: CircularProgressIndicator());
                                      } else {
                                        return SimpleDialog(
                                          title: const Text('Wrong Questions'),
                                          children: List.generate(
                                            allmistakes.length,
                                            (index) => SimpleDialogOption(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(allmistakes[index].question),
                                                  SizedBox(height: 10.h),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (ctx) => const ExamAnswerScreen()));
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
                                                        child: const Text('View Answer'),
                                                      ),
                                                      SizedBox(width: 20.w),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              Provider.of<QuestionHistoryProvider>(context, listen: false)
                                                                  .getParallelQuestion(context, allmistakes[index].qId);
                                                              return Consumer<QuestionHistoryProvider>(
                                                                builder: (context, parallel, _) {
                                                                  return SimpleDialog(
                                                                    title: const Text('Parallel Options'),
                                                                    children: List.generate(
                                                                      parallel.allParallelQuestions.length,
                                                                      (index) => SimpleDialogOption(
                                                                        onPressed: () {
                                                                          Navigator.of(context).push(MaterialPageRoute(
                                                                              builder: (ctx) => ExamParallelQuestion(
                                                                                    selectedParallel: index,
                                                                                    id: allmistakes[index].qId,
                                                                                  )));
                                                                        },
                                                                        child: Text(
                                                                          'Parallel ${index + 1}',
                                                                          style: TextStyle(fontSize: 15.sp),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
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
                                                        child: const Text('Answer Parallel'),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
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
                                onPressed: () async {
                                  await examHistoryProvider.getExamReccomendationData(context, e.id);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      if (examHistoryProvider.allrecs.isEmpty) {
                                        return const Center(child: CircularProgressIndicator());
                                      } else {
                                        return SimpleDialog(
                                          title: const Text('Recommended'),
                                          children: List.generate(
                                            examHistoryProvider.allrecs.length,
                                            (index) => Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  examHistoryProvider.allrecs[index].chapteName,
                                                  style: TextStyle(fontSize: 14.sp),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (ctx) => CheckoutScreen(
                                                          chapterName: examHistoryProvider
                                                              .allrecs[index].chapteName,
                                                          price: examHistoryProvider
                                                              .allrecs[index].prices[index].price
                                                              .toDouble(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.r),
                                                    ),
                                                    backgroundColor: Colors.redAccent[700],
                                                    foregroundColor: Colors.white,
                                                  ),
                                                  child: const Text('Buy'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
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
