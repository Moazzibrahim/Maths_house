

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile',style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: const Center(
        child: Text('Profile Screen Content'),
      ),
    );
  }
}