import 'package:flutter/material.dart';
class CoursesCard extends StatelessWidget {
  const CoursesCard({Key? key, required this.image, required this.text}) : super(key: key);

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      elevation: 3,
      child: SizedBox(
        height: 150,
        width: 150, // Adjust width as needed
        child: Image.asset(image),
      ),
    );
  }
}
