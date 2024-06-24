import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/my_courses/chapters_screen.dart';
import 'package:flutter_application_1/View/widgets/unregistered_courses_custom.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/courses_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

//180 line api line
class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  void initState() {
    Provider.of<CoursesProvider>(context, listen: false)
        .getCoursesData(context);
    super.initState();
  }

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
        padding: EdgeInsets.all(6.0.h),
        child: Consumer<CoursesProvider>(
          builder: (context, coursesProvider, _) {
            if (coursesProvider.allcourses.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: coursesProvider.allcourses.length,
                itemBuilder: (context, index) {
                  final course = coursesProvider.allcourses[index];
                  return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ChaptersScreen(
                                  title: course.name,
                                  course: course,
                                )));
                      },
                      child: CustomUnregisteredWidgets(
                        text: course.name,
                        image: course.courseUrl,
                      ));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
