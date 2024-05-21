// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/auth_screens/confirm_password.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int _countdown = 180; // 3 minutes in seconds
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_countdown < 1) {
            timer.cancel();
            // Add your logic when the countdown reaches 0
          } else {
            _countdown--;
          }
        });
      },
    );
  }

  String get timerText {
    int minutes = _countdown ~/ 60;
    int seconds = _countdown % 60;
    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr = (seconds < 10) ? '0$seconds' : '$seconds';
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 60.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 214, 212, 212),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      appBar: buildAppBar(context, ' MathHouse'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Container(
          margin: EdgeInsets.only(top: 40.h),
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  "OTP Verification",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Enter the OTP sent to - +91-8976500001 ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Pinput(
                  length: 5,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.red),
                    ),
                  ),
                  onCompleted: (pin) => debugPrint(pin),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  " $timerText",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Don’t receive code ?',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Re-send',
                      style: TextStyle(
                        color: faceBookColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmPassword(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: faceBookColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 130.w,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r))),
                child: Text(
                  maxLines: 1,
                  'submit',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
