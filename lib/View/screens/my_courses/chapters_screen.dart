import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/courses_model.dart';
import 'package:flutter_application_1/View/widgets/chapters_tiles.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/chapters_provider.dart';
import 'package:provider/provider.dart';

class ChaptersScreen extends StatefulWidget {
  const ChaptersScreen({super.key, required this.title, required this.course});
  final String title;
  final Course course;

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  @override
  void initState() {
    Provider.of<ChapterProvider>(context, listen: false)
        .getChaptersData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
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
              )),
        ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ChapterProvider>(
            builder: (context, chapterProvider, _) {
              if (chapterProvider.allChapters.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  children: chapterProvider.allChapters
                      .where((e) => e.courseId == widget.course.courseId)
                      .map((e) => ChaptersTiles(chapter: e))
                      .toList(),
                );
              }
            },
          ),
        ));
  }
}
