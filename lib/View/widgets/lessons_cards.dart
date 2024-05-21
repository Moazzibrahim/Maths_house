import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/lessons_model.dart';
import 'package:flutter_application_1/View/screens/my_courses/lesson_video_screen.dart';

class LessonCards extends StatelessWidget {
  const LessonCards({super.key, required this.lesson});
  final Lesson lesson;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => LessonsVideos(
                  lesson: lesson,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.circle,
              size: 10,
              color: Colors.redAccent[700],
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              lesson.name,
              style: TextStyle(
                color: Colors.redAccent[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
