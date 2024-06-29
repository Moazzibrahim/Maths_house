import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
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
  @override
  void initState() {
    Provider.of<ExamHistoryProvider>(context, listen: false)
        .getExamReccomendationData(context, widget.id);
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
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
                                  builder: (ctx) => CheckoutScreen(
                                    chapterName: allrecs[i].chapteName,
                                    price: allrecs[i].prices[i].price.toDouble(),
                                  ),
                                ),
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
