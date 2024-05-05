import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPackage extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomPackage({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? gridHomeColor : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          width: double.maxFinite,
          height: 120.h,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text1,
                  style: const TextStyle(color: faceBookColor, fontSize: 20),
                ),
                Text(
                  text2,
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                Text(
                  'Duration: $text3',
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                Text(
                  'price: $text4',
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}