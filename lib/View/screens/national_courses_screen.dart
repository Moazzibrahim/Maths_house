import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/widgets/card_widget.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class NationalCoursesScreen extends StatelessWidget {
  const NationalCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'National'),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CardWidget(ChapterNo: 'Chapter 1'),
            CardWidget(ChapterNo: 'Chapter 2'),
            CardWidget(ChapterNo: 'Chapter 3'),
            CardWidget(ChapterNo: 'Chapter 4'),
          ],
        ),
      ),
    );
  }
}
