import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/all_courses/all_courses_screen.dart';
import 'package:flutter_application_1/View/screens/registered_home_screen.dart';
import 'package:flutter_application_1/View/widgets/unregistered_courses_custom.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/all_courses_provider.dart';
import 'package:provider/provider.dart';

class UnregisteredCourses extends StatefulWidget {
  const UnregisteredCourses({super.key});

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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: gridHomeColor, borderRadius: BorderRadius.circular(12)),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisteredHomeScreen()));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.redAccent[700],
              )),
        ),
      ),
      body: Padding(
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
          )),
    );
  }
}
