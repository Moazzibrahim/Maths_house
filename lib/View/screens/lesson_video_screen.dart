import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/lessons_model.dart';


class LessonsVideos extends StatelessWidget {
  const LessonsVideos({super.key, required this.lesson});
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.name),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView.builder(
        itemCount: lesson.videos!.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  
                  Text(lesson.videos![index].videoName ?? 'no video'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
