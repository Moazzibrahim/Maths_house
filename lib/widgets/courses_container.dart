import 'package:flutter/material.dart';

class CoursesCard extends StatelessWidget {
  const CoursesCard({super.key, required this.image, required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            elevation: 3,
            child: SizedBox(
              height: 150,
              width: 150,
              child: Image.asset(image)
              ) ,
          ),
          Text(text),
        ],
      ),
    );
  }
}

