import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Model/lessons_model.dart';
import 'package:flutter_application_1/View/widgets/ideas_content.dart';
import 'package:flutter_application_1/View/widgets/quizzes_content.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LessonsVideos extends StatefulWidget {
  const LessonsVideos({super.key, required this.lesson});
  final Lesson lesson;

  @override
  State<LessonsVideos> createState() => _LessonsVideosState();
}

class _LessonsVideosState extends State<LessonsVideos> {
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.lesson.name),
          leading: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: gridHomeColor, borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              onPressed: () {
                toggleRotation();
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
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  IdeasContent(lesson: widget.lesson,),// replace this text with ideas Widgets
                  QuizzesContent(lessonId:widget.lesson.lessonId ,),
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
