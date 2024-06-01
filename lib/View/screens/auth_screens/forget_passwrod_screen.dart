import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/auth_screens/otp_verification_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendForgetPasswordRequest() async {
    // final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    // final token = tokenProvider.token;

    setState(() {
      _isLoading = true;
    });

    final String user = _controller.text;
    final String url =
        'https://login.mathshouse.net/api/forget_password';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'user': user,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(user: user),
          ),
        );
      } else {
        final responseJson = jsonDecode(response.body);
        final errorMessage =
            responseJson['message']?.toString() ?? 'Failed to update password';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update password: $errorMessage')),
        );
      }
    } catch (e) {
      print('An error occurred: $e');
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
    return Scaffold(
      appBar: buildAppBar(context, 'Maths House'),
      body: Padding(
        padding: EdgeInsets.all(19.w),
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (BuildContext context, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Forget password ',
                    style: TextStyle(
                      fontSize: 20.sp,
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
                SizedBox(height: 15.sp),
                RichText(
                  text: TextSpan(
                    text:
                        'Don\'t worry! that happens. Please \n register your phone or email to \n which we will send your One Time \n Password ',
                    style: TextStyle(
                      fontSize: 15.sp,
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
                SizedBox(height: 10.sp),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Enter Phone Or Email',
                  ),
                ),
                SizedBox(height: 25.sp),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _sendForgetPasswordRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: faceBookColor,
                          padding: EdgeInsets.symmetric(
                            vertical: 12.sp,
                            horizontal: 130.sp,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.sp),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
