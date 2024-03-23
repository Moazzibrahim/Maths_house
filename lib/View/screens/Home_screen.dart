import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/courses_container.dart';
import 'package:flutter_application_1/widgets/custom_carousel_containers.dart';
import 'package:flutter_application_1/widgets/custom_small_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int containerIndex = 0;
  List<Widget> carouselContainer = [
    const CarouselContainer(color: Color.fromRGBO(172, 191, 253, 1), text: 'Get best Grades',image: 'assets/images/woman.jpg',),
    const CarouselContainer(color: Color.fromRGBO(198, 221, 239, 1), text: '',image: 'assets/images/maths.jpg',),
    const CarouselContainer(color: Color.fromRGBO(2, 153, 234, 1), text: 'Get the best Maths experience!',image: 'assets/images/7605117.jpg',),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/images/moaz.jpeg'), // Your image path here
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Welcome Moaz', // Change 'John' to the desired name
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
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
              const SizedBox(height: 10,),
              DotsIndicator(
                dotsCount: carouselContainer.length,
                position: containerIndex,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 135,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:  [
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
                  const Text('Trending courses',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  TextButton(onPressed: (){}, child:const Text('See All',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))
                ],
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 200, // Adjust the height as needed
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CoursesCard(image: 'assets/images/maths.jpg', text: 'The course name'),
                    CoursesCard(image: 'assets/images/maths.jpg', text: 'The course name'),
                    CoursesCard(image: 'assets/images/maths.jpg', text: 'The course name'),
                    CoursesCard(image: 'assets/images/maths.jpg', text: 'The course name'),
                    CoursesCard(image: 'assets/images/maths.jpg', text: 'The course name'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

