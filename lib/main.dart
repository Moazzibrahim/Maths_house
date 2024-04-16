import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/widgets/onboarding_check.dart';
import 'package:flutter_application_1/controller/Timer_provider.dart';
import 'package:flutter_application_1/controller/chapters_provider.dart';
import 'package:flutter_application_1/controller/courses_provider.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_exam_provider.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_filteration_provider.dart';
import 'package:flutter_application_1/controller/exam/exam_mcq_provider.dart';
import 'package:flutter_application_1/controller/exam/exam_provider.dart';
import 'package:flutter_application_1/controller/history_controllers/question_history_controller.dart';
import 'package:flutter_application_1/controller/live_provider.dart';
import 'package:flutter_application_1/controller/question_provider.dart';
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
        ChangeNotifierProvider(create: (_) => QuestionsProvider()),
        ChangeNotifierProvider(create: (_) => DiagnosticFilterationProvider()),
        ChangeNotifierProvider(create: (_) => QuestionHistoryProvider()),
        ChangeNotifierProvider(create: (_) => DiagExamProvider()),
      ],
      child: const ScreenUtilInit(
        minTextAdapt: true,
        designSize: Size(360, 690),
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Facebook Login Page',
          home: OnBoardingCheck(),
        ),
      ),
    );
  }
}
