import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/all_courses/select_course.dart';
import 'package:flutter_application_1/View/screens/exam-view/exam_filteration_screen.dart';
import 'package:flutter_application_1/View/screens/live/live_screen.dart';
import 'package:flutter_application_1/View/screens/questions_filter_screen.dart';
import 'package:flutter_application_1/View/screens/Diagnostic_exams/filter_screen.dart';
import 'package:flutter_application_1/View/screens/history_screens/history_screen.dart';
import 'package:flutter_application_1/View/widgets/grid_container.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisteredHomeScreen extends StatelessWidget {
  const RegisteredHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    profileProvider.getprofileData(context);
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          children: [
            CircleAvatar(
              radius: 21.r,
              backgroundImage: const AssetImage('assets/images/logo.png'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Consumer<ProfileProvider>(
                builder: (context, profileProvider, _) {
                  final userData = profileProvider.userData;
                  if (userData == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
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
                          height: 10,
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
                          builder: (ctx) => const SelectCourse()));
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
