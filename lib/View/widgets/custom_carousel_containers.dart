import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselContainer extends StatelessWidget {
  const CarouselContainer({
    super.key,
    required this.color,
    required this.text,
    required this.image,
  });

  final Color color;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive width and height for the container
    double containerWidth = screenWidth * 0.8; // 80% of screen width
    double containerHeight = containerWidth * 0.5; // Aspect ratio of 2:1

    // Calculate responsive width and height for the image
    double imageWidth = containerWidth * 0.5; // 60% of container width
    double imageHeight = containerHeight * 0.7; // 70% of container height

    return Container(
      padding: const EdgeInsets.all(8),
      width: containerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
          SizedBox(
            width: imageWidth,
            height: imageHeight,
            child: Image.asset(
              image,
              fit: BoxFit.cover, // Ensure the image covers the entire space
            ),
          )
        ],
      ),
    );
  }
}
