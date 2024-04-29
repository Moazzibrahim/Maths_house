import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/View/widgets/textfield_widget.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isvisText = true;
  TextEditingController newName = TextEditingController();
  TextEditingController newEmail = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Maths House'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const ListTile(
                title: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  'Create a new account',
                  style: TextStyle(
                      color: Color.fromARGB(255, 103, 101, 101), fontSize: 15),
                ),
              ),
              CustomTextField(
                controller: newName,
                hintText: 'Name',
                isvisText: true,
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
                        : Icons.visibility_off_outlined)),
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
                        : Icons.visibility_off_outlined)),
                isvisText: !isvisText,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TabsScreen(
                              isLoggedIn: false,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: faceBookColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 130.w,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Divider(
                      color: Colors.black,
                    )),
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
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
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
                            color: Colors.redAccent[700], fontSize: 15),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
