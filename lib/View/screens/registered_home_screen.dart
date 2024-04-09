import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/View/screens/courses_screen.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_filteration_screen.dart';
import 'package:flutter_application_1/View/screens/live_screen.dart';
import 'package:flutter_application_1/View/screens/questions_filter_screen.dart';
import 'package:flutter_application_1/View/widgets/grid_container.dart';
import 'package:flutter_application_1/constants/colors.dart';

class RegisteredHomeScreen extends StatelessWidget {
  const RegisteredHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/logo.jpg'),
                  ),
                ],
              ),
              const Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/moaz.jpeg'),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Welcome student',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GridView(
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const CoursesScreen()));
                    },
                    child: GridContainer(
                      text: 'Courses',
                      color: gridHomeColor,
                      styleColor: Colors.redAccent[700],
                      image: 'assets/images/verify.png',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const ExamFilterScreen()));
                    },
                    child: GridContainer(
                      text: 'Exams',
                      color: gridHomeColor,
                      styleColor: Colors.redAccent[700],
                      image: 'assets/images/a+.png',
                    ),
                  ),
                  GridContainer(
                    text: 'Live',
                    color: gridHomeColor,
                    styleColor: Colors.redAccent[700], image: 'assets/images/play-cricle.png',
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const QuestionFilterScreen()));
                    },
                    child: GridContainer(
                      text: 'Questions',
                      color: gridHomeColor,
                      styleColor: Colors.redAccent[700],
                      image:
                          'assets/images/290138_document_extension_file_format_paper_icon 1.png',
                    ),
                  ),
                  GridContainer(
                    text: 'Diagnostic Exams',
                    color: gridHomeColor,
                    styleColor: Colors.redAccent[700],
                    image: 'assets/images/Frame 232.png',
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const LiveScreen()));
                    },
                    child: GridContainer(
                      text: 'History',
                      color: gridHomeColor,
                      styleColor: Colors.redAccent[700], image: 'assets/images/timer.png',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
