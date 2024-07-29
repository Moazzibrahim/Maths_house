import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/auth_screens/login_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/profile/country_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  String? selectedGrade;
  String? selectedCountry;
  String? selectedCity;

  Future<void> signuppost(BuildContext context) async {
    var fname = fnameController.text;
    var lname = lnameController.text;
    var nickname = nicknameController.text;
    var email = emailController.text;
    var phone = phoneController.text;
    var password = passwordController.text;
    var confpassword = confPasswordController.text;

    try {
      Map<String, dynamic> data = {
        "f_name": fname,
        "l_name": lname,
        "password": password,
        "nick_name": nickname,
        "email": email,
        "phone": phone,
        "city_id": 8,
        "conf_password": confpassword,
        "grade": selectedGrade,
      };

      final response = await http.post(
        Uri.parse('https://login.mathshouse.net/api/stu_sign_up_add'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        print(response.body);
        // Handle successful response if needed
      } else {
        print('Failed to post data: ${response.statusCode}');
        print(response.body);
        // Handle failure, maybe inform the user
      }
    } catch (e) {
      print('Error: $e');
      // Handle error, inform the user
    }
  }

  @override
  void initState() {
    Provider.of<SignupProvider>(context, listen: false)
        .fetchCountry()
        .catchError((e) {
      print(e);
    });
    Provider.of<SignupProvider>(context, listen: false)
        .fetchCity()
        .catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context, signupProvider, _) {
        return Scaffold(
          appBar: buildAppBar(context, 'Sign Up'),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: fnameController,
                    labelText: 'First Name*',
                    icon: Icons.person_outline,
                    isvisText: true,
                  ),
                  const SizedBox(width: 10),
                  CustomTextField(
                    controller: lnameController,
                    labelText: 'Last Name*',
                    icon: Icons.person_outline,
                    isvisText: true,
                  ),
                  CustomTextField(
                    controller: nicknameController,
                    labelText: 'Nickname*',
                    icon: Icons.person_outline,
                    isvisText: true,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    labelText: 'Phone Number*',
                    icon: Icons.phone_outlined,
                    isvisText: true,
                  ),
                  CustomTextField(
                    controller: emailController,
                    labelText: 'Email*',
                    icon: Icons.email_outlined,
                    isvisText: true,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    labelText: 'Password*',
                    icon: Icons.lock_outline,
                    passIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: faceBookColor,
                      ),
                    ),
                    isvisText: !isPasswordVisible,
                  ),
                  CustomTextField(
                    controller: confPasswordController,
                    labelText: 'Confirm Password*',
                    icon: Icons.lock_outline,
                    passIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isConfirmPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: faceBookColor,
                      ),
                    ),
                    isvisText: !isConfirmPasswordVisible,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select Grade*',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: faceBookColor,
                            width: 1.5), // Change border color to red
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: faceBookColor,
                            width: 1.5), // Change border color when focused
                      ),
                      prefixIcon: const Icon(Icons.grade,
                          color: faceBookColor), // Add an icon
                    ),
                    value: selectedGrade,
                    onChanged: (newValue) {
                      setState(() {
                        selectedGrade = newValue;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'grade 1',
                        child: Text('Grade 1'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 2',
                        child: Text('Grade 2'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 3',
                        child: Text('Grade 3'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 4',
                        child: Text('Grade 4'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 5',
                        child: Text('Grade 5'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 6',
                        child: Text('Grade 6'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 7',
                        child: Text('Grade 7'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 8',
                        child: Text('Grade 8'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 9',
                        child: Text('Grade 9'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 10',
                        child: Text('Grade 10'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 11',
                        child: Text('Grade 11'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 12',
                        child: Text('Grade 12'),
                      ),
                      DropdownMenuItem(
                        value: 'grade 13',
                        child: Text('Grade 13'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () async {
                      // Check if any field is empty
                      if (fnameController.text.isEmpty ||
                          lnameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          confPasswordController.text.isEmpty ||
                          phoneController.text.isEmpty ||
                          nicknameController.text.isEmpty ||
                          selectedGrade == null) {
                        // Show error message for each empty field
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: faceBookColor,
                            content: Text("All fields are required"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return; // Stop further execution
                      }
                      // Check if password and confirm password match
                      if (passwordController.text !=
                          confPasswordController.text) {
                        // Show error message to the user
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: faceBookColor,
                            content: Text(
                                "Password and Confirm Password do not match"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return; // Stop further execution
                      }
                      // All fields are filled and passwords match, proceed with signup
                      await signuppost(context);
                      // Show dialog only when password matches confirm password
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Sign Up Success'),
                            content: const Text(
                                'Your confirmation has been sent to your email, please check.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: faceBookColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 130.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: faceBookColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? icon;
  final IconButton? passIcon;
  final bool isvisText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.icon,
    this.passIcon,
    required this.isvisText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: !isvisText,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: icon != null ? Icon(icon, color: faceBookColor) : null,
          suffixIcon: passIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: faceBookColor, // Default border color
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: faceBookColor, // Border color when focused
              width: 1.5, // Border width when focused
            ),
          ),
        ),
      ),
    );
  }
}
