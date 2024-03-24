// ignore_for_file: file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/login_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/widgets/courses_container.dart';
import 'package:flutter_application_1/widgets/custom_carousel_containers.dart';
import 'package:flutter_application_1/widgets/custom_small_container.dart';

class UnregisteredHomescreen extends StatefulWidget {
  const UnregisteredHomescreen({Key? key}) : super(key: key);

  @override
  State<UnregisteredHomescreen> createState() => _UnregisteredHomescreenState();
}

class _UnregisteredHomescreenState extends State<UnregisteredHomescreen> {
  int containerIndex = 0;
  List<Widget> carouselContainer = [
    const CarouselContainer(
      color: Color.fromRGBO(172, 191, 253, 1),
      text: 'Get best Grades',
      image: 'assets/images/woman.jpg',
    ),
    const CarouselContainer(
      color: Color.fromRGBO(198, 221, 239, 1),
      text: '',
      image: 'assets/images/maths.jpg',
    ),
    const CarouselContainer(
      color: Color.fromRGBO(2, 153, 234, 1),
      text: 'Get the best Maths experience!',
      image: 'assets/images/7605117.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              CarouselSlider(
                items: carouselContainer,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      containerIndex = index;
                    });
                  },
                ),
              ),
              SizedBox(height: 10.h),
              DotsIndicator(
                dotsCount: carouselContainer.length,
                position: containerIndex,
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 135.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CustomSmallCard(
                      icon: Icons.book_rounded,
                      color: Colors.red[200],
                      text: 'Courses',
                      iconColor: Colors.red,
                    ),
                    CustomSmallCard(
                      icon: Icons.assignment,
                      color: Colors.yellow[100],
                      text: 'Exams',
                      iconColor: Colors.yellow[700],
                    ),
                    CustomSmallCard(
                      icon: Icons.assessment,
                      color: Colors.blue[200],
                      text: 'Diagnostic',
                      iconColor: Colors.blue[700],
                    ),
                    CustomSmallCard(
                      icon: Icons.question_mark,
                      color: Colors.green[200],
                      text: 'Questions',
                      iconColor: Colors.green[700],
                    ),
                    CustomSmallCard(
                      icon: Icons.live_tv,
                      color: Colors.purple[200],
                      text: 'Live',
                      iconColor: Colors.purple,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trending courses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: faceBookColor,
                          ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 200.h, // Adjust the height as needed
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CoursesCard(
                      image: 'assets/images/maths.jpg',
                      text: 'The course name',
                    ),
                    SizedBox(width: 20), // Add spacing between cards
                    CoursesCard(
                      image: 'assets/images/maths.jpg',
                      text: 'The course name',
                    ),
                    SizedBox(width: 20), // Add spacing between cards
                    CoursesCard(
                      image: 'assets/images/maths.jpg',
                      text: 'The course name',
                    ),
                    SizedBox(width: 20), // Add spacing between cards
                    CoursesCard(
                      image: 'assets/images/maths.jpg',
                      text: 'The course name',
                    ),
                    SizedBox(width: 20), // Add spacing between cards
                    CoursesCard(
                      image: 'assets/images/maths.jpg',
                      text: 'The course name',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  const Text(
                    "Do you have an account ?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: faceBookColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
