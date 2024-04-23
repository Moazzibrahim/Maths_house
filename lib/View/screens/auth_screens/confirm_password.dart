import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/auth_screens/login_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({super.key});

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  late TextEditingController passwordController;
  late TextEditingController confirmpasswordController;

  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmpasswordController =TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context);

    return Scaffold(
      appBar: buildAppBar(context, 'Math house'),
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
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
