import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/onboarding_screen.dart';
import 'package:flutter_application_1/controller/Timer_provider.dart';
import 'package:flutter_application_1/controller/chapters_provider.dart';
import 'package:flutter_application_1/controller/courses_provider.dart';
import 'package:flutter_application_1/controller/exam_mcq_provider.dart';
import 'package:flutter_application_1/controller/exam_provider.dart';
import 'package:flutter_application_1/controller/live_provider.dart';
import 'package:flutter_application_1/controller/start_exam_provider.dart';

import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MathHouse());
}

class MathHouse extends StatelessWidget {
  const MathHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenModel()),
        ChangeNotifierProvider(
          create: (_) => LoginModel(),
        ),
        ChangeNotifierProvider(create: (_) => CoursesProvider()),
        ChangeNotifierProvider(
          create: (_) => TimerProvider(),
        ),
        ChangeNotifierProvider(create: (_) => ChapterProvider()),
        ChangeNotifierProvider(create: (_) => LiveProvider()),
        ChangeNotifierProvider(create: (_) => ExamProvider()),
        ChangeNotifierProvider(create: (_) => StartExamProvider()),
        ChangeNotifierProvider(create: (_) => ExamMcqProvider()),
      ],
      child: const ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Facebook Login Page',
          home: OnBoardingScreen(),
        ),
      ),
    );
  }
}
