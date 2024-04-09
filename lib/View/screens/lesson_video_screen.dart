import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Model/lessons_model.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsVideos extends StatelessWidget {
  const LessonsVideos({super.key, required this.lesson});
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lesson.name),
          leading: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: gridHomeColor, borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              onPressed: () {
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
              const Expanded(
                child: TabBarView(children: [
                  Text('Ideas content'),// replace this text with ideas Widgets
                  Text('quizes content'),//replace this text with quizes content
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
