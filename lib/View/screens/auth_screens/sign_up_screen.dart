// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/sign_up/country_model.dart';
import 'package:flutter_application_1/View/screens/auth_screens/login_screen.dart';
import 'package:flutter_application_1/View/widgets/textfield_widget.dart';
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
  bool isvisText = true;
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
  int indexOfCity = 0;
  int cityid = 0;

  Future<void> signuppost(BuildContext context) async {
    var fname = fnameController.text;
    var lname = lnameController.text;
    var nickname = nicknameController.text;
    var email = emailController.text;
    var phone = phoneController.text;
    var password = passwordController.text;
    var confpassword = confPasswordController.text;

    // Check if password and confirm password match
    if (password != confpassword) {
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password and Confirm Password do not match"),
        duration: Duration(seconds: 2),
      ));
      return; // Stop further execution
    }

    try {
      Map<String, dynamic> data = {
        "f_name": fname,
        "l_name": lname,
        "password": password,
        "nick_name": nickname,
        "email": email,
        "phone": phone,
        "city_id": cityid,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: fnameController,
                          hintText: 'First Name*',
                          isvisText: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          controller: lnameController,
                          hintText: 'Last Name*',
                          isvisText: true,
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email*',
                    isvisText: true,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password*',
                    passIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isvisText = !isvisText;
                        });
                      },
                      icon: Icon(isvisText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                    isvisText: !isvisText,
                  ),
                  CustomTextField(
                    controller: confPasswordController,
                    hintText: 'Confirm Password*',
                    passIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isvisText = !isvisText;
                        });
                      },
                      icon: Icon(isvisText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                    isvisText: !isvisText,
                  ),
                  if (passwordController.text != confPasswordController.text)
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Password does not match',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  CustomTextField(
                    controller: phoneController,
                    hintText: 'Phone Number*',
                    isvisText: true,
                  ),
                  CustomTextField(
                    controller: nicknameController,
                    hintText: 'Nickname*',
                    isvisText: true,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedCountry,
                          hint: const Text('Select Country*'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCountry = newValue;
                            });
                          },
                          items: signupProvider.allcountries
                              .map<DropdownMenuItem<String>>((Country country) {
                            return DropdownMenuItem<String>(
                              value: country.name,
                              child: Text(
                                country.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedCity,
                          hint: const Text('Select City*'),
                          onChanged: (String? newValue) async {
                            setState(() {
                              selectedCity = newValue!;
                            });

                            City selectedCityObject =
                                signupProvider.allcities.firstWhere(
                              (city) => city.name == newValue,
                              orElse: () =>
                                  City(id: -1, countryId: '', name: ''),
                            );

                            // Check if a city was found
                            if (selectedCityObject.id != -1) {
                              setState(() {
                                cityid = selectedCityObject.id;
                              });
                            }
                          },
                          items: signupProvider.allcities
                              .map<DropdownMenuItem<String>>((city) {
                            return DropdownMenuItem<String>(
                              value: city.name,
                              child: Text(
                                city.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Select Grade*',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                      // Continue adding DropdownMenuItem for each grade up to 13
                      DropdownMenuItem(
                        value: 'grade 13',
                        child: Text('Grade 13'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                          selectedCountry == null ||
                          selectedCity == null ||
                          selectedGrade == null) {
                        // Show error message for each empty field
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("All fields are required"),
                          duration: Duration(seconds: 2),
                        ));
                        return; // Stop further execution
                      }

                      // Check if password and confirm password match
                      if (passwordController.text !=
                          confPasswordController.text) {
                        // Show error message to the user
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "Password and Confirm Password do not match"),
                          duration: Duration(seconds: 2),
                        ));
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
                            content:
                                const Text('You have successfully signed up.'),
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
                                child: const Text('Login'),
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Or Login With'),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/google.png'),
                      const SizedBox(
                        width: 50,
                      ),
                      Image.asset('assets/images/apple.png'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.redAccent[700],
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
