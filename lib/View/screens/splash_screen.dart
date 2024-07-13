// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/widgets/onboarding_check.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart'; // Add the main screen import

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      String? token = prefs.getString('token');

      if (isLoggedIn && token != null) {
        Provider.of<TokenModel>(context, listen: false).setToken(token);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const TabsScreen(
              isLoggedIn: false), // Redirect with isLoggedIn: true
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const OnBoardingCheck(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashScreen.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
