import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/chapters_model.dart';
import 'package:flutter_application_1/View/widgets/lessons_cards.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/chapters_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChaptersTiles extends StatefulWidget {
  const ChaptersTiles({super.key, required this.chapter});
  final Chapter chapter;

  @override
  State<ChaptersTiles> createState() => _ChaptersTilesState();
}

class _ChaptersTilesState extends State<ChaptersTiles> {
  bool istapped = true;

  @override
  void initState() {
    Provider.of<ChapterProvider>(context, listen: false)
        .getLessonsData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: istapped ? gridHomeColor : const Color.fromARGB(255, 234, 228, 228),
      margin: EdgeInsets.symmetric(vertical: 15.h),
      elevation: 3,
      child: ExpansionTile(
        onExpansionChanged: (_) {
          setState(() {
            istapped = !istapped;
          });
        },
        title: Row(
          children: [
            Icon(
              Icons.video_collection_rounded,
              color: faceBookColor,
              size: 24.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Text(
                widget.chapter.name,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        ),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        children: [
          Consumer<ChapterProvider>(
            builder: (context, lessonsProvider, _) {
              final lesson = lessonsProvider.allLessons;
              return Column(
                children: lesson
                    .where((e) => e.chapterId == widget.chapter.id)
                    .map((e) => LessonCards(lesson: e))
                    .toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
