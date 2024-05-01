// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Model/sign_up/country_model.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/View/widgets/textfield_widget.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/profile/country_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isvisText = true;
  TextEditingController newFirstName = TextEditingController();
  TextEditingController newLastName = TextEditingController();
  TextEditingController newEmail = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  TextEditingController newPhone = TextEditingController();
  TextEditingController newNickName = TextEditingController();
  String? selectedGrade; // To store the selected grade
  String? selectedCountry; // To store the selected country
  String? selectedCity; // To store the selected city

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
      builder: (context, SignupProvider, _) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Scaffold(
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
                            controller: newFirstName,
                            hintText: 'First Name',
                            isvisText: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            controller: newLastName,
                            hintText: 'Last Name',
                            isvisText: true,
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      controller: newEmail,
                      hintText: 'Email',
                      isvisText: true,
                    ),
                    CustomTextField(
                      controller: newPass,
                      hintText: 'Password',
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
                      controller: confirmPass,
                      hintText: 'Confirm Password',
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
                      controller: newPhone,
                      hintText: 'Phone Number',
                      isvisText: true,
                    ),
                    CustomTextField(
                      controller: newNickName,
                      hintText: 'Nickname',
                      isvisText: true,
                    ),

                    // Dropdown button for selecting country
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.5, // Adjust the width as needed
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedCountry,
                            hint: const Text('Select Country'),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCountry = newValue;
                              });
                            },
                            items: SignupProvider.allcountries
                                .map<DropdownMenuItem<String>>(
                                    (Country country) {
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
                        const SizedBox(width: 10), // Add some extra spacing
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.4, // Adjust the width as needed
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedCity,
                            hint: const Text('Select City'),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCity = newValue!;
                              });
                            },
                            items: SignupProvider.allcities
                                .map<DropdownMenuItem<String>>((City city) {
                              return DropdownMenuItem<String>(
                                value: city.name,
                                child: Text(
                                  maxLines: 1,
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
                        hintText: 'Select Grade',
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
                      items: List.generate(
                        13,
                        (index) => DropdownMenuItem(
                          value: (index + 1).toString(),
                          child: Text('Grade ${index + 1}'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TabsScreen(
                              isLoggedIn: false,
                            ),
                          ),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 25),
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
          ),
        );
      },
    );
  }
}
