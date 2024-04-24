import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/act_courses_screen.dart';
import 'package:flutter_application_1/View/screens/ect_courses_screen.dart';
import 'package:flutter_application_1/View/screens/sat_courses.dart';
import 'package:flutter_application_1/View/widgets/unregistered_courses_custom.dart';
import 'package:flutter_application_1/constants/colors.dart';

class AmericanCoursesScreen extends StatelessWidget {
  const AmericanCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Courses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: gridHomeColor, borderRadius: BorderRadius.circular(12)),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.redAccent[700],
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SatCourses()),
                );
              },
              child: const CustomUnregisteredWidgets(text: 'SAT')),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EctCoursesScreen()),
                );
              },
              child: const CustomUnregisteredWidgets(text: 'ECT')),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ActCoursesScreen()),
                );
              },
              child: const CustomUnregisteredWidgets(text: 'ACT')),
        ]),
      ),
    );
  }
}
