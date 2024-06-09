import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/View/widgets/Exams/start_exam_widget.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ExamScreenstart extends StatelessWidget {
  final int? examcodeid;
  final int? courseid;
  final int? categoryid;
  final int? months;
  final String? years;

  const ExamScreenstart(
      {super.key,
      this.examcodeid,
      this.courseid,
      this.categoryid,
      this.months,
      this.years});

  @override
  Widget build(BuildContext context) {
    // Simulated list of exams
    List<String> exams = [
      'Exam 1',
    ];

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false); // Prevent back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exams'),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: faceBookColor,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const TabsScreen(isLoggedIn: false)));
              }),
        ),
        body: ListView.builder(
          itemCount: exams.length,
          itemBuilder: (context, index) {
            return ExamGridItem(
              examName: exams[index],
              categoryid: categoryid,
              courseid: courseid,
              examcodeid: examcodeid,
              months: months,
              years: years,
            );
          },
        ),
      ),
    );
  }
}
