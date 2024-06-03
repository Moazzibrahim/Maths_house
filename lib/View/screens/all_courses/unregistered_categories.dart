import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/all_courses/all_courses_screen.dart';
import 'package:flutter_application_1/View/widgets/unregistered_courses_custom.dart';
import 'package:flutter_application_1/View/widgets/unregistered_profile.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/all_courses_provider.dart';
import 'package:provider/provider.dart';

class UnregisteredCourses extends StatefulWidget {
  const UnregisteredCourses({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  State<UnregisteredCourses> createState() => _UnregisteredCoursesState();
}

class _UnregisteredCoursesState extends State<UnregisteredCourses> {
  @override
  void initState() {
    Provider.of<CategoriesServices>(context, listen: false)
        .getAllCategoriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !widget.isLoggedIn
          ? buildAppBar(context, 'Categories')
          : AppBar(
              title: const Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
      body: !widget.isLoggedIn
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<CategoriesServices>(
                builder: (context, catProvider, _) {
                  if (catProvider.allCategouries.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: catProvider.allCategouries.length,
                      itemBuilder: (context, index) {
                        final category = catProvider.allCategouries[index];
                        final courses =
                            catProvider.allCategouries[index].coursesCategories;
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    AllCoursesScreen(courses: courses)));
                          },
                          child: CustomUnregisteredWidgets(
                            text: category.catName,
                            image: category.catUrl,
                          ),
                        );
                      },
                    );
                  }
                },
              ))
          : const UnregisteredProfile(
              text: 'Login first to access this screen'),
    );
  }
}
