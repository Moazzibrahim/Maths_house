// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/all_courses/all_courses_screen.dart';
import 'package:flutter_application_1/View/widgets/unregistered_courses_custom.dart';
import 'package:flutter_application_1/View/widgets/unregistered_profile.dart';
import 'package:flutter_application_1/controller/all_courses_provider.dart';
import 'package:provider/provider.dart';

class UnregisteredCourses extends StatefulWidget {
  const UnregisteredCourses({super.key, required this.isLoggedIn, required this.isFromCourses});
  final bool isLoggedIn;
  final bool isFromCourses;

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
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false); // Prevent back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: widget.isFromCourses? IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back)) : null
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
                          final courses = catProvider
                              .allCategouries[index].coursesCategories;
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
      ),
    );
  }
}
