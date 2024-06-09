import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/Diagnostic_exams/filter_screen.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_filteration_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/history_screen.dart';
import 'package:flutter_application_1/View/screens/live/all_sessions_screen.dart';
import 'package:flutter_application_1/View/screens/live/history_live_screen.dart';
import 'package:flutter_application_1/View/screens/live/my_live_Sceen.dart';
import 'package:flutter_application_1/View/screens/live/private_live_screen.dart';
import 'package:flutter_application_1/View/screens/live/upcoming_screen.dart';
import 'package:flutter_application_1/View/screens/my_courses/courses_screen.dart';
import 'package:flutter_application_1/View/screens/questions_filter_screen.dart';
import 'package:flutter_application_1/View/widgets/grid_container.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Live'),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const UpComingScreen()));
            },
            child: GridContainer(
              text: 'UpComing Live',
              color: gridHomeColor,
              styleColor: Colors.redAccent[700],
              image: 'assets/images/verify.png',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const HistoryLiveScreen()));
            },
            child: GridContainer(
              text: 'History Live',
              color: gridHomeColor,
              styleColor: Colors.redAccent[700],
              image: 'assets/images/a+.png',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const AllSessionsScreen()));
            },
            child: GridContainer(
              text: 'All Sessions',
              color: gridHomeColor,
              styleColor: Colors.redAccent[700],
              image: 'assets/images/play-cricle.png',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const PrivateLiveScreen()));
            },
            child: GridContainer(
              text: 'Private Live',
              color: gridHomeColor,
              styleColor: Colors.redAccent[700],
              image:
                  'assets/images/290138_document_extension_file_format_paper_icon 1.png',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const MyLiveScreen()));
            },
            child: GridContainer(
              text: 'My Live',
              color: gridHomeColor,
              styleColor: Colors.redAccent[700],
              image: 'assets/images/Frame 232.png',
            ),
          ),
        ],
      ),
    );
  }
}
