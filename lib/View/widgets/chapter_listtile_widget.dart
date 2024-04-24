import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class ChapterListTileWidgts extends StatelessWidget {
  const ChapterListTileWidgts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: const Row(
        children: [
          Icon(
            Icons.video_collection_rounded,
            color: faceBookColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "leson 1",
            style: TextStyle(color: faceBookColor),
          ),
        ],
      ),
    );
  }
}