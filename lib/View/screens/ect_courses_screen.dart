import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/widgets/card_widget.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class EctCoursesScreen extends StatelessWidget {
  const EctCoursesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'ECT'),
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
