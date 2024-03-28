import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/chapters_model.dart';
import 'package:flutter_application_1/View/widgets/lessons_cards.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/services/chapters_provider.dart';
import 'package:provider/provider.dart';

class ChaptersTiles extends StatefulWidget {
  const ChaptersTiles({super.key, required this.chapter});
  final Chapter chapter;

  @override
  State<ChaptersTiles> createState() => _ChaptersTilesState();
}

class _ChaptersTilesState extends State<ChaptersTiles> {
  @override
  void initState() {
    Provider.of<ChapterProvider>(context, listen: false)
        .getLessonsData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      elevation: 3,
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(
              Icons.video_collection_rounded,
              color: faceBookColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.chapter.name),
          ],
        ),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
