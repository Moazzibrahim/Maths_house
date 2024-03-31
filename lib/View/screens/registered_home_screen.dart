import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/courses_screen.dart';
import 'package:flutter_application_1/View/screens/exam_filteration_screen.dart';
import 'package:flutter_application_1/View/screens/live_screen.dart';
import 'package:flutter_application_1/View/widgets/grid_container.dart';

class RegisteredHomeScreen extends StatelessWidget {
  const RegisteredHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
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
              const SizedBox(
                height: 10,
              ),
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const CoursesScreen()));
                    },
                    child: GridContainer(
                      text: 'Courses',
                      color: Colors.red[200],
                      styleColor: Colors.redAccent[700],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const ExamFilterScreen()));
                    },
                    child: GridContainer(
                      text: 'Exams',
                      color: Colors.blue[200],
                      styleColor: Colors.blueAccent[700],
                    ),
                  ),
                  GridContainer(
                    text: 'Quizes',
                    color: Colors.purple[200],
                    styleColor: Colors.purpleAccent[700],
                  ),
                  GridContainer(
                    text: 'Questions',
                    color: Colors.green[200],
                    styleColor: Colors.greenAccent[700],
                  ),
                  GridContainer(
                    text: 'Diagnostic Exams',
                    color: Colors.yellow[200],
                    styleColor: Colors.yellow[800],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const LiveScreen()));
                    },
                    child: GridContainer(
                      text: 'Live',
                      color: Colors.indigo[200],
                      styleColor: Colors.indigoAccent[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
