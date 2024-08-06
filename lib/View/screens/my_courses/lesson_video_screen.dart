import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Model/lessons_model.dart';
import 'package:flutter_application_1/Model/score_sheet/score_sheet_model.dart';
import 'package:flutter_application_1/View/widgets/ideas_content.dart';
import 'package:flutter_application_1/View/widgets/quizzes_content.dart';
import 'package:flutter_application_1/View/widgets/score_sheet_content.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsVideos extends StatefulWidget {
  const LessonsVideos({super.key, required this.lesson});
  final Lesson lesson;

  @override
  State<LessonsVideos> createState() => _LessonsVideosState();
}

class _LessonsVideosState extends State<LessonsVideos> {
  bool isLandscapeGlobal = false;

  void toggleRotation() {
    if (isLandscapeGlobal) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    setState(() {
      isLandscapeGlobal = !isLandscapeGlobal;
    });
  }

  void setDefaultOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Updated to 3 for the new Score Sheet tab
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.lesson.name),
          leading: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: gridHomeColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                setDefaultOrientation();
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.redAccent[700],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  labelPadding:
                      EdgeInsets.zero, // No padding between label and indicator
                  indicator: BoxDecoration(
                    color: Colors.redAccent[700],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.redAccent[700],
                  tabs: const [
                    _CustomTab(text: 'Ideas'),
                    _CustomTab(text: 'Quizzes'),
                    _CustomTab(text: 'Score Sheet'), // New tab
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  IdeasContent(
                    lesson: widget.lesson,
                  ), // Ideas tab content
                  QuizzesContent(
                    lessonId: widget.lesson.lessonId,
                  ), // Quizzes tab content
                  ScoreSheetContent(
                    scoreData: ScoreData(
                        quizName: "quizName",
                        score: 60,
                        time: "30",
                        date: "30/8",
                        mistakes: 9),
                        lessid: widget.lesson.lessonId,
                  ), // New Score Sheet tab content
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTab extends StatelessWidget {
  final String text;

  const _CustomTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
