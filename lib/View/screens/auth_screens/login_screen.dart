import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/auth_screens/forget_passwrod_screen.dart';
import 'package:flutter_application_1/View/screens/auth_screens/sign_up_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late String errorMessage = '';
  bool obscurePassword = true; // Track password visibility

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                "assets/images/logo.jpg",
                width: 200.w,
                height: 200.h,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Facebook blue color
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text('Welcome to Maths house!'),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: TextField(
                  controller: passwordController,
                  obscureText:
                      obscurePassword, // Use obscurePassword to toggle visibility
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword =
                              !obscurePassword; // Toggle password visibility
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
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetPasswordScreen()),
                      );
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: faceBookColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () async {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();
                  Provider.of<LoginModel>(context, listen: false)
                      .loginUser(context, email, password);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: faceBookColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 140.w,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r))),
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 6.h, horizontal: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider(color: Colors.black)),
                    SizedBox(width: 10.w),
                    const Text('Or Login With'),
                    SizedBox(width: 10.w),
                    const Expanded(child: Divider(color: Colors.black)),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/google.png'),
                  SizedBox(width: 50.w),
                  Image.asset('assets/images/apple.png'),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const SignUpScreen()));
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromRGBO(207, 32, 47, 1),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
