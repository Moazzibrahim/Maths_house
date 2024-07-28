import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingWidgets extends StatelessWidget {
  const OnBoardingWidgets({
    super.key,
    required this.description,
    required this.image,
    required this.showSkipButton,
  });

  final String description;
  final String image;
  final bool showSkipButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0.w), // Responsive padding
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 200.h, // Responsive height
              width: 200.w,  // Responsive width
            ),
            SizedBox(
              height: 10.h, // Responsive spacing
            ),
            Text(
              description,
              style: TextStyle(fontSize: 16.sp), // Responsive font size
            ),
            SizedBox(
              height: 150.h, // Responsive spacing
            ),
            if (showSkipButton)
              TextButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isNewUser', false);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const TabsScreen(isLoggedIn: true),
                    ),
                  );
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.redAccent[700],
                    fontSize: 20.sp, // Responsive font size
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
