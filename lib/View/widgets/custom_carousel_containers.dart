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
    return Container(
      padding: const EdgeInsets.all(8),
      width: 300.w,
      height: 150.h,
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
            width: 90.w,
            height: 90.h,
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
