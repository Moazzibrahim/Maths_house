import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MathHouse());
}

class MathHouse extends StatelessWidget {
  const MathHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Facebook Login Page',
        home: TabsScreen(isLoggedIn: true,),
      ),
    );
  }
}
