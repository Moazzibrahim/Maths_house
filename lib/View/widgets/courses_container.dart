import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CoursesCard extends StatelessWidget {
  const CoursesCard({super.key, required this.image, required this.text});

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 140.h,
            width: 200.w, // Adjust width as needed
            child: Image.asset(image),
          ),
          Text(text,style: TextStyle(fontSize: 15,color: Colors.redAccent[700]),),
        ],
      ),
    );
  }
}
