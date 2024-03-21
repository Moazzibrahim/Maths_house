import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/login_screen.dart';

void main() {
  runApp(const MathHouse());
}

class MathHouse extends StatelessWidget {
  const MathHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook Login Page',
      theme: ThemeData(
        primaryColor: const Color(0xFF1877f2), // Facebook blue color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
    );
  }
}


