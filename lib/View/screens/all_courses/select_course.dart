import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/all_courses/unregistered_categories.dart';
import 'package:flutter_application_1/View/screens/my_courses/courses_screen.dart';
import 'package:flutter_application_1/View/widgets/grid_container.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class SelectCourse extends StatelessWidget {
  const SelectCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Courses'),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const CoursesScreen()),
                );
              },
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridContainer(
                    text: 'My Courses',
                    color: gridHomeColor,
                    styleColor: Colors.redAccent[700],
                    image: 'assets/images/verify.png',
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) =>
                        const UnregisteredCourses(isLoggedIn: false),
                  ),
                );
              },
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridContainer(
                    text: 'All Courses',
                    color: gridHomeColor,
                    styleColor: Colors.redAccent[700],
                    image: 'assets/images/icons8-books-64.png',
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ), // Spacer to push the content to the center
          ],
        ),
      ),
    );
  }
}
