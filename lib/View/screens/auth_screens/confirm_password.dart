// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/auth_screens/login_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfirmPassword extends StatefulWidget {
  final String user;
  final String code;

  const ConfirmPassword({Key? key, required this.user, required this.code})
      : super(key: key);

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  late TextEditingController passwordController;
  late TextEditingController confirmpasswordController;
  bool obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmpasswordController = TextEditingController();
  }

  Future<void> _updatePassword() async {
    //final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    //  final token = tokenProvider.token;

    if (passwordController.text != confirmpasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    const String url = 'https://login.mathshouse.net/api/update_password';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          //    'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'user': widget.user,
          'code': widget.code,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
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
      print('An error occurred: $e'); // Print the error to the debug console

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
    // Initialize ScreenUtil
    ScreenUtil.init(
      context,
      designSize: Size(360, 690), // Change this to your design size
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      appBar: buildAppBar(context, 'Math House'),
      body: Padding(
        padding: EdgeInsets.all(15.w), // Use ScreenUtil for padding
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'New password',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight:
                          FontWeight.w400), // Use ScreenUtil for font size
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Create a new password',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.redAccent[700],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: TextField(
                controller: confirmpasswordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.redAccent[700],
                    ),
                  ),
                ),
              ),
            ),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _updatePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: faceBookColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 130.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12.r), // Use ScreenUtil for border radius
                      ),
                    ),
                    child: Text(
                      maxLines: 1,
                      'Continue',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
