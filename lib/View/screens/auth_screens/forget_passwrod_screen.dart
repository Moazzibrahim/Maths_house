import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/auth_screens/otp_verification_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Maths House'),
      body: Padding(
        padding: EdgeInsets.all(19.w), // Use ScreenUtil for padding
        child: ScreenUtilInit(
          designSize: const Size(375, 812), // Define your design size
          builder: (BuildContext context, Widget? child) {
            return Container(
              // Wrap your Column with a Container
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Forget password ',
                      style: TextStyle(
                        fontSize: 20.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: '?',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.sp, // Use ScreenUtil for height
                  ),
                  RichText(
                    text: TextSpan(
                      text:
                          'Don\'t worry! that happens. Please \n register your phone or email to \n which we will send your One Time \n Password ',
                      style: TextStyle(
                        fontSize: 15.sp, // Use ScreenUtil for font size
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: '(OTP)',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.sp, // Use ScreenUtil for height
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: 'Enter Phone Or Email',
                    ),
                  ),
                  SizedBox(
                    height: 25.sp, // Use ScreenUtil for height
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OtpVerificationScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: faceBookColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.sp, // Use ScreenUtil for padding
                        horizontal: 130.sp, // Use ScreenUtil for padding
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12.sp), // Use ScreenUtil for border radius
                      ),
                    ),
                    child: const Text(
                      maxLines: 1,
                      'Continue',
                      style: TextStyle(
                        fontSize: 15, // Use ScreenUtil for font size
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
