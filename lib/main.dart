import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/delete_account/delete_account.dart';
import 'package:flutter_application_1/Model/live/live_filteration_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/splash_screen.dart';
import 'package:flutter_application_1/controller/Timer_provider.dart';
import 'package:flutter_application_1/controller/all_courses_provider.dart';
import 'package:flutter_application_1/controller/chapters_provider.dart';
import 'package:flutter_application_1/controller/courses_provider.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_exam_provider.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_filteration_provider.dart';
import 'package:flutter_application_1/controller/diagnostic/get_course_provider.dart';
import 'package:flutter_application_1/controller/exam/exam_mcq_provider.dart';
import 'package:flutter_application_1/controller/exam/exam_provider.dart';
import 'package:flutter_application_1/controller/exam/get_exam_provider.dart';
import 'package:flutter_application_1/controller/exam/start_exam_provider.dart';
import 'package:flutter_application_1/controller/exam_code_provider.dart';
import 'package:flutter_application_1/controller/history_controllers/dia_exam_history_controller.dart';
import 'package:flutter_application_1/controller/history_controllers/exam_history_controller.dart';
import 'package:flutter_application_1/controller/history_controllers/question_history_controller.dart';
import 'package:flutter_application_1/controller/history_controllers/quiz_history_controller.dart';
import 'package:flutter_application_1/controller/live_provider.dart';
import 'package:flutter_application_1/controller/package/package_provider.dart';
import 'package:flutter_application_1/controller/payment_history_provider.dart';
import 'package:flutter_application_1/controller/payment_method_provider.dart';
import 'package:flutter_application_1/controller/profile/country_provider.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_application_1/controller/question_provider.dart';
import 'package:flutter_application_1/controller/quiz_provider.dart';
import 'package:flutter_application_1/controller/student_quiz_score_provider.dart';
import 'package:flutter_application_1/controller/wallet_history_provider.dart';
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
        ChangeNotifierProvider(
          create: (_) => ChapterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LiveProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExamProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StartExamProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExamMcqProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuestionsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DiagnosticFilterationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuestionHistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DiagExamProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExamHistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DiaExamHistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuizHistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuizzesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignupProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetCourseProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PackageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PaymentProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WalletProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PaymentHistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoriesServices(),
        ),
        ChangeNotifierProvider(
          create: (_) => DeleteAccount(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetExamProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LiveFilterationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StudentQuizScoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExamCodeProvider(),
        ),

        // ChangeNotifierProvider(
        //   create: (_) => LiveFilterProvider(),
        // ),
      ],
      child: const ScreenUtilInit(
        minTextAdapt: true,
        designSize: Size(360, 690),
        splitScreenMode: true,
        child: MaterialApp(
          //theme: ThemeData(primaryColor: Colors.white),
          debugShowCheckedModeBanner: false,
          title: 'Facebook Login Page',
          home: SplashScreen(),
        ),
      ),
    );
  }
}
