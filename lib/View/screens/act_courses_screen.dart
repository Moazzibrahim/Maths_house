import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/widgets/card_widget.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class ActCoursesScreen extends StatelessWidget {
  const ActCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'ACT'),
      body: SingleChildScrollView(
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
