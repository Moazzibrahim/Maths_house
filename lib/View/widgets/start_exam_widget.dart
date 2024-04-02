import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_screen.dart';
import 'package:flutter_application_1/controller/start_exam_provider.dart';
import 'package:provider/provider.dart';

class ExamGridItem extends StatefulWidget {
  final String examName;
  final int index; // Add the index parameter

  const ExamGridItem({
    required this.examName,
    required this.index, // Add the index parameter
    Key? key,
  }) : super(key: key);

  @override
  State<ExamGridItem> createState() => _ExamGridItemState();
}

class _ExamGridItemState extends State<ExamGridItem> {
  @override
  void initState() {
    super.initState();
    Provider.of<StartExamProvider>(context, listen: false).getExamData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StartExamProvider>(
      builder: (context, startExamProvider, _) {
        List<Map<String, dynamic>> examData = startExamProvider.examData;
        List<int>? months = startExamProvider.months; // Make months nullable
        List<String>? years = startExamProvider.years; // Make years nullable
        List<int>? questionCounts = startExamProvider.questionCounts; // Make questionCounts nullable
        List<List<String>>? sections = startExamProvider.sections; // Make sections nullable

        return startExamProvider.examData.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Are you sure to start Exam?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                // Handle start button tap
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ExamScreen(),
                                  ),
                                );
                              },
                              child: const Text('Start'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Card(
                      elevation: 2.0,
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
                                  months?.isNotEmpty == true
                                      ? months![widget.index].toString()
                                      : "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  years?.isNotEmpty == true
                                      ? years![widget.index].toString()
                                      : "",
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
                                        'Number of Questions',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        questionCounts?.isNotEmpty == true
                                            ? questionCounts![widget.index]
                                                .toString()
                                            : "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Sections',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        sections?.isNotEmpty == true
                                            ? sections[widget.index]
                                                .length
                                                .toString()
                                            : "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Marks',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "20",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
