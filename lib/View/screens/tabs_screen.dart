// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/all_courses/unregistered_categories.dart';
import 'package:flutter_application_1/View/screens/package_screen.dart';
import 'package:flutter_application_1/View/screens/profile_screen.dart';
import 'package:flutter_application_1/View/screens/registered_home_screen.dart';
import 'package:flutter_application_1/View/screens/unregistered_Home_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [];
  @override
  void initState() {
    pages = [
      widget.isLoggedIn
          ? const UnregisteredHomescreen()
          : const RegisteredHomeScreen(),
      PackageScreen(
        isLoggedIn: widget.isLoggedIn,
      ),
      UnregisteredCourses(isLoggedIn: widget.isLoggedIn,),
      ProfileScreen(
        isLoggedIn: widget.isLoggedIn,
      ),
    ];
    super.initState();
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white, 
          selectedItemColor: faceBookColor,
          unselectedItemColor: Colors.redAccent[700],
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'Packages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_sharp),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 28,
              ),
              label: 'Profile',
            ),
          ],
          onTap: onItemTapped),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: const Center(
        child: Text('Chat Screen Content'),
      ),
    );
  }
}
