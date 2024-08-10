
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/history_screens/question_answer_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/exam_history_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExamOptionScreen extends StatefulWidget {
  const ExamOptionScreen({super.key, required this.id});

  final int id;

  @override
  State<ExamOptionScreen> createState() => _ExamOptionScreenState();
}

class _ExamOptionScreenState extends State<ExamOptionScreen> {
  bool isLoaded = false;
  @override
  void initState() {
    Provider.of<ExamHistoryProvider>(context, listen: false)
        .getExamViewMistakesData(context, widget.id);
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
      appBar: buildAppBar(context, 'Exam Actions'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ExamHistoryProvider>(
          builder: (context, mistakeProvider, _) {
            final allMistakes = mistakeProvider.allmistakes;
            if (allMistakes.isEmpty) {
              return isLoaded
                  ? const Center(
                      child: Text('There is no Data in this section right now'))
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            } else {
              return ListView.builder(
                itemCount: allMistakes.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Image.network(allMistakes[i].qUrl),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => QuestionAnswerScreen(
                                        id: allMistakes[i].qId,
                                      )));
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
                        ],
                      ),
                      const SizedBox(
                        height: 10,
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
