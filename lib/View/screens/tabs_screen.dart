// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/home_screen.dart';
import 'package:flutter_application_1/View/screens/profile_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const BooksScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
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
          backgroundColor: Colors
              .white, // Set the background color of the entire BottomNavigationBar here
          selectedItemColor: faceBookColor,
          unselectedItemColor: Colors.black,
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: onItemTapped),
    );
  }
}

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: const Center(
        child: Text('Books Screen Content'),
      ),
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


