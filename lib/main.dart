import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/login_screen.dart';

void main() {
  runApp(const MathHouse());
}

class MathHouse extends StatelessWidget {
  const MathHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facebook Login Page',
      home: LoginPage(),
    );
  }
}


