import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/chapters_screen.dart';
import 'package:flutter_application_1/services/courses_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
        title: const Text(
          'Courses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding:  EdgeInsets.all(6.0.h),
        child: Consumer<CoursesProvider>(builder: (context, coursesProvider, _) {
          if (coursesProvider.allcourses.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              itemCount: coursesProvider.allcourses.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                final course = coursesProvider.allcourses[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx)=> ChaptersScreen(title: course.name,))
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 7.w,
                          vertical: 5.h,
                        ),
                        elevation: 3,
                        child: SizedBox(
                          height: 150,
                          width: 150, // Adjust width as needed
                          child: Image.network(''),
                        ),
                      ),
                    ),
                    Text(course.name),
                  ],
                );
              },
            );
          }
        }),
      ),
    );
  }
}
