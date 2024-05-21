import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/my_courses/courses_screen.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_filteration_screen.dart';
import 'package:flutter_application_1/View/screens/live_screen.dart';
import 'package:flutter_application_1/View/screens/questions_filter_screen.dart';
import 'package:flutter_application_1/View/screens/Diagnostic_exams/filter_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/history_screen.dart';
import 'package:flutter_application_1/View/widgets/grid_container.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:provider/provider.dart';

class RegisteredHomeScreen extends StatelessWidget {
  const RegisteredHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ProfileProvider and fetch user data
    final profileProvider = Provider.of<ProfileProvider>(context);
    profileProvider.getprofileData(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Consumer<ProfileProvider>(
                builder: (context, profileProvider, _) {
                  final userData = profileProvider.userData;
                  if (userData == null) {
                    return const CircularProgressIndicator(); // Show loading indicator until user data is fetched
                  } else {
                    return Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/logo.jpg'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              // Use the user's image here
                              backgroundImage: NetworkImage(userData.image),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Welcome ${userData.nickname}',
                              style: const TextStyle(
                                color: faceBookColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    );
                  }
                },
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const LiveScreen()));
                    },
                    child: GridContainer(
                      text: 'Live',
                      color: gridHomeColor,
                      styleColor: Colors.redAccent[700],
                      image: 'assets/images/play-cricle.png',
                    ),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const DiagnosticFilterScreen()));
                    },
                    child: GridContainer(
                      text: 'Diagnostic Exams',
                      color: gridHomeColor,
                      styleColor: Colors.redAccent[700],
                      image: 'assets/images/Frame 232.png',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const HistoryScreen()));
                    },
                    child: GridContainer(
                      text: 'History',
                      color: gridHomeColor,
                      styleColor: Colors.redAccent[700],
                      image: 'assets/images/timer.png',
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
