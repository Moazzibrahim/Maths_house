import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/onboarding_screen.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingCheck extends StatefulWidget {
  const OnBoardingCheck({super.key});

  @override
  State<OnBoardingCheck> createState() => _OnBoardingCheckState();
}

class _OnBoardingCheckState extends State<OnBoardingCheck> {
    bool _isNewUser = false;
    @override
  void initState() {
    super.initState();
    checkIfNewUser();
  }
    Future<void> checkIfNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isNewUser = prefs.getBool('isNewUser') ?? true;
    setState(() {
      _isNewUser = isNewUser;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(_isNewUser){
      return const OnBoardingScreen();
    }else{
      return const TabsScreen(isLoggedIn: true);
    }
  }
}