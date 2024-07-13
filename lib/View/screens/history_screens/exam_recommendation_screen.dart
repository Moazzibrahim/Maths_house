import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_duration.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/exam_history_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExamRecommendationScreen extends StatefulWidget {
  const ExamRecommendationScreen({super.key, required this.id});
  final int id;

  @override
  State<ExamRecommendationScreen> createState() =>
      _ExamRecommendationScreenState();
}

class _ExamRecommendationScreenState extends State<ExamRecommendationScreen> {
  bool isLoaded = false;
  @override
  void initState() {
    Provider.of<ExamHistoryProvider>(context, listen: false)
        .getExamReccomendationData(context, widget.id);
    Future.delayed(
      const Duration(seconds: 3),
      () {
        setState(() {
          isLoaded = true;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Reccomendation'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ExamHistoryProvider>(
          builder: (context, reccomendationProvider, _) {
            final allrecs = reccomendationProvider.allrecs;
            if (allrecs.isEmpty) {
              return isLoaded
                  ? const Center(
                      child: Text('There is no Data in this section right now'))
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            } else {
              final List<double> prices = [];
              final List<int> durations = [];
              final List<double> discount = [];
              for (var e in allrecs) {
                for (var j in e.prices) {
                  prices.add(j.price);
                }
              }
              for (var e in allrecs) {
                for (var j in e.prices) {
                  durations.add(j.duration.toInt());
                }
              }
              for (var e in allrecs) {
                for (var j in e.prices) {
                  discount.add(j.discount.toDouble());
                }
              }
              log('prices: $prices');
              return ListView.builder(
                itemCount: allrecs.length,
                itemBuilder: (context, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allrecs[i].chapteName,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (ctx) => ExamDuration(
                                          chapterNames: allrecs
                                              .map(
                                                (e) => e.chapteName,
                                              )
                                              .toList(),
                                          discounts: discount,
                                          durations: durations,
                                          ids: allrecs
                                              .map(
                                                (e) => e.id.toInt(),
                                              )
                                              .toList(),
                                          prices: prices,
                                        )),
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
                            child: const Text('Buy'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
