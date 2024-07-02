import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/View/screens/onboarding_screen.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:flutter_application_1/View/screens/auth_screens/login_screen.dart'; // Add the login screen import

class OnBoardingCheck extends StatefulWidget {
  const OnBoardingCheck({super.key});

  @override
  State<OnBoardingCheck> createState() => _OnBoardingCheckState();
}

class _OnBoardingCheckState extends State<OnBoardingCheck> {
  bool _isNewUser = true;

  @override
  void initState() {
    super.initState();
    checkIfNewUser();
  }

  Future<void> checkIfNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isNewUser = prefs.getBool('isNewUser') ?? true;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? token = prefs.getString('token');

    setState(() {
      _isNewUser = isNewUser;
    });

    if (isLoggedIn && token != null) {
      Provider.of<TokenModel>(context, listen: false).setToken(token);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const TabsScreen(
            isLoggedIn: false), // Redirect with isLoggedIn: true
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isNewUser) {
      return const OnBoardingScreen();
    } else {
      return const TabsScreen(
          isLoggedIn: false); // Redirect with isLoggedIn: true
    }
  }
}
