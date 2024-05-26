import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/exam/start_exam_provider.dart';
import 'package:provider/provider.dart';

class ExamGridItem extends StatefulWidget {
  final String examName;
  final int? examcodeid;
  final int? courseid;
  final int? categoryid;
  final int? months;
  final String? years;

  const ExamGridItem({
    required this.examName,
    super.key,
    this.examcodeid,
    this.courseid,
    this.categoryid,
    this.months,
    this.years,
  });

  @override
  State<ExamGridItem> createState() => _ExamGridItemState();
}

class _ExamGridItemState extends State<ExamGridItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StartExamProvider>(
      builder: (context, startExamProvider, _) {
        final lll = startExamProvider.examData.toList();
        if (startExamProvider.examData.isEmpty) {
          // Fetch data only if it's not already fetched
          startExamProvider.fetchDataFromApi(context, {
            'category_id': widget.categoryid,
            'course_id': widget.courseid,
            'year': widget.years,
            'month': widget.months,
            'code_id': widget.examcodeid,
          });
          return const Center(
            child: CircularProgressIndicator(), // Show loading indicator
          );
        }
        return Column(
          children: lll.map((examData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Card(
                  elevation: 2.0,
                  color: gridHomeColor,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Month: ${examData.month}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Year: ${examData.year}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    '# Questions',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      "${examData.countOfQuestions}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: faceBookColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Sections',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  // Text(
                                  //   examData.section!,
                                  //   style: const TextStyle(
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: 11,
                                  //     color: faceBookColor,
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    'Score',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${examData.marks}",
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: faceBookColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          width: 150,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Are you sure to start Exam?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ExamScreen(),
                                              ),
                                            );
                                          },
                                          child: const Text('Start'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: faceBookColor,
                              ),
                              child: const Text(
                                "Start",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
