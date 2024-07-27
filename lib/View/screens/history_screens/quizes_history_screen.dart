
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/history_models/quizes_history_model.dart';
import 'package:flutter_application_1/View/screens/history_screens/quiz_mistakes_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/history_controllers/quiz_history_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class QuizesHistoryScreen extends StatefulWidget {
  const QuizesHistoryScreen({super.key});

  @override
  State<QuizesHistoryScreen> createState() => _QuizesHistoryScreenState();
}

class _QuizesHistoryScreenState extends State<QuizesHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtStart = true;

  @override
  void initState() {
    super.initState();
    Provider.of<QuizHistoryProvider>(context, listen: false)
        .getQuizHistory(context);

    _scrollController.addListener(() {
      setState(() {
        _isAtStart = _scrollController.position.pixels == 0;
      });
    });
  }

  Widget _buildDetailDialog(BuildContext context, QuizHistory e) {
    return AlertDialog(
      title: const Text('Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Course: ${e.courseName}'),
          Text('Chapter: ${e.chapterName}'),
          Text('Lesson: ${e.lessonName}'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void _scrollHorizontally() {
    if (_isAtStart) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Quizes History'),
      body: Consumer<QuizHistoryProvider>(
        builder: (context, quizHistoryProvider, _) {
          if(quizHistoryProvider.allQuizHistory.isEmpty){
            return const Center(child: Text('no quizes history'));
          }else{
            return LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                        ),
                        child: DataTable(
                          dataRowMaxHeight: 55.h,
                          columnSpacing: 25.w,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text('Date'),
                            ),
                            DataColumn(
                              label: Text('Quiz Details'),
                            ),
                            DataColumn(
                              label: Text('Score'),
                            ),
                            DataColumn(
                              label: Text('Actions'),
                            ),
                            DataColumn(
                              label: Text('Grade'),
                            ),
                            DataColumn(
                              label: Text('No. of Questions'),
                            ),
                            DataColumn(
                              label: Text('Score Details'),
                            ),
                            DataColumn(
                              label: Text('Time'),
                            ),
                          ],
                          rows: <DataRow>[
                            for (var e in quizHistoryProvider.allQuizHistory)
                              DataRow(
                                cells: [
                                  DataCell(Text(e.date)),
                                  DataCell(
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _buildDetailDialog(
                                                context, e);
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 7.h, horizontal: 5.w),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        backgroundColor: Colors.redAccent[700],
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text('View Details'),
                                    ),
                                  ),
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
                                                "Are you sure you want to view the answer for this question?",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                  quizHistoryProvider.getDiaRecommedations(context);
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(builder: (ctx)=> const QuizMistakesScreen() )
                                                  );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.redAccent[700],
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(12.r)
                                                    ),
                                                  ),
                                                  child: const Text('Yes'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 7.h, horizontal: 5.w),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        backgroundColor: Colors.redAccent[700],
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text('View Mistake'),
                                    ),
                                  ),
                                  DataCell(Text(e.score.toString())),
                                  DataCell(Text(e.questions.length.toString())),
                                  DataCell(
                                    Column(
                                      children: [
                                        Text(
                                            'Right answers: ${e.rightCount.toString()}'),
                                        Text(
                                            'Wrong answers: ${e.questions.length - e.rightCount}'),
                                      ],
                                    ),
                                  ),
                                  DataCell(Text(e.time)),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: _scrollHorizontally,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isAtStart ? Icons.arrow_forward : Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          }
          
        },
      ),
    );
  }
}
