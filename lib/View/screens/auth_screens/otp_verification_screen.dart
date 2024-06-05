import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/View/screens/auth_screens/confirm_password.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpVerificationScreen extends StatefulWidget {
  final String user;

  const OtpVerificationScreen({Key? key, required this.user}) : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int _countdown = 180; // 3 minutes in seconds
  late Timer _timer;
  String _pin = '';
  bool _isLoading = false;

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

  Future<void> _sendVerificationCode() async {
    setState(() {
      _isLoading = true;
    });

    final String url = 'https://login.mathshouse.net/api/confirm_code';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //  'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'user': widget.user,
          'code': _pin,
        }),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseData['success'] == 'Congratulations Code Is Right') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ConfirmPassword(user: widget.user, code: _pin),
            ),
          );
        } else if (responseData['faild'] == 'Code Is Wrong') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Code is wrong'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected response: ${response.body}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to verify code: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
                  "Enter the OTP sent to - ${widget.user}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.red),
                    ),
                  ),
                  onCompleted: (pin) => setState(() {
                    _pin = pin;
                  }),
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
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _sendVerificationCode,
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
                        'Submit',
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
