import 'package:flutter/material.dart';
class CoursesCard extends StatelessWidget {
  const CoursesCard({super.key, required this.image, required this.text});

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 170,
            width: 200, // Adjust width as needed
            child: Image.asset(image),
          ),
          Text(text,style: TextStyle(fontSize: 15,color: Colors.redAccent[700]),),
        ],
      ),
    );
  }
}
