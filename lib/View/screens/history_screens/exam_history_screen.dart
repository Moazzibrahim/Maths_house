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
      body: Consumer<ExamHistoryProvider>(
        builder: (context, examHistoryProvider, _) {
          final allmistakes = examHistoryProvider.allmistakes;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  DataTable(
                    dataRowMaxHeight: 55.h,
                    columnSpacing: 25,
                    columns: const [
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
                            DataCell(
                              ElevatedButton(
                                onPressed: () async{
                                  log('${e.id}');
                                  await Provider.of<ExamHistoryProvider>(
                                          context,
                                          listen: false)
                                      .getExamViewMistakesData(context, e.id);
                                        showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    builder: (context) {
                                      if(allmistakes.isEmpty){
                                        return const Center(child: CircularProgressIndicator(),);
                                      }else{
                                      return SimpleDialog(
                                        title: const Text('wrong questions'),
                                        children: List.generate(
                                            allmistakes.length,
                                            (index) => SimpleDialogOption(
                                                  child: Column(
                                                    children: [
                                                      Text(allmistakes[index]
                                                          .question),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (ctx) =>
                                                                              const ExamAnswerScreen()));
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          7,
                                                                      horizontal:
                                                                          5),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.redAccent[
                                                                      700],
                                                              foregroundColor:
                                                                  Colors.white,
                                                            ),
                                                            child: const Text(
                                                                'view answer'),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  Provider.of<QuestionHistoryProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .getParallelQuestion(
                                                                          context,
                                                                          allmistakes[index]
                                                                              .qId);
                                                                  return Consumer<
                                                                      QuestionHistoryProvider>(
                                                                    builder:
                                                                        (context,
                                                                            parallel,
                                                                            _) {
                                                                      return SimpleDialog(
                                                                        title: const Text(
                                                                            'Parallel options'),
                                                                        children:
                                                                            List.generate(
                                                                          parallel
                                                                              .allParallelQuestions
                                                                              .length,
                                                                          (index) =>
                                                                              SimpleDialogOption(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).push(MaterialPageRoute(
                                                                                  builder: (ctx) => ExamParallelQuestion(
                                                                                        selectedParallel: index,
                                                                                        id: allmistakes[index].qId,
                                                                                      )));
                                                                            },
                                                                            child:
                                                                                Text(
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
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          7,
                                                                      horizontal:
                                                                          5),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.redAccent[
                                                                      700],
                                                              foregroundColor:
                                                                  Colors.white,
                                                            ),
                                                            child: const Text(
                                                                'Answer parallel'),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )),
                                      );}
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
                                child: const Text('View mistake'),
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                onPressed: () async {
                                  await examHistoryProvider.getExamReccomendationData(
                                      context, e.id);
                                  showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    builder: (context) {
                                      if(examHistoryProvider.allrecs.isEmpty){
                                        return const Center(child: CircularProgressIndicator());
                                      }else {
                                      return SimpleDialog(
                                          title: const Text('Reccomended'),
                                          children: List.generate(
                                              examHistoryProvider
                                                  .allrecs.length,
                                              (index) => Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(examHistoryProvider
                                                          .allrecs[index]
                                                          .chapteName),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (ctx) =>
                                                                      CheckoutScreen(
                                                                        chapterName: examHistoryProvider
                                                                            .allrecs[index]
                                                                            .chapteName,
                                                                        price: examHistoryProvider
                                                                            .allrecs[index]
                                                                            .prices[index]
                                                                            .price
                                                                            .toDouble(),
                                                                      )));
                                                        },
                                                        child:
                                                            const Text('Buy'),
                                                      ),
                                                    ],
                                                  )));}
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
