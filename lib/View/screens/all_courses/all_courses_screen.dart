import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/all_courses_model.dart';
import 'package:flutter_application_1/View/screens/all_courses/purchase_course_screen.dart';
import 'package:flutter_application_1/View/widgets/unregistered_courses_custom.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class AllCoursesScreen extends StatelessWidget {
  const AllCoursesScreen({super.key, required this.courses});
  final List<CoursesCategories> courses;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Courses'),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx)=> PurchaseCourseScreen(course: courses[index]))
              );
            },
            child: CustomUnregisteredWidgets(
                text: courses[index].courseName, image: courses[index].courseUrl),
          );
        },
      ),
    );
  }
}
