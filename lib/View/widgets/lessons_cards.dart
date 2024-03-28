import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/lessons_model.dart';

class LessonCards extends StatelessWidget {
  const LessonCards({super.key, required this.lesson});
  final Lesson lesson;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.blue[200],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.play_circle_outline_rounded),
            const SizedBox(width: 10,),
            Text(lesson.name),
          ],
        ),
      ),
    );
  }
}