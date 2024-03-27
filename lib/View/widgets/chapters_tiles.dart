import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/chapters_model.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ChaptersTiles extends StatelessWidget {
  const ChaptersTiles({super.key, required this.chapter});
  final Chapter chapter;
  
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
            Text(chapter.name),
          ],
        ),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
