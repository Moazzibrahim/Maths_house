import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPackage extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;

  final bool isSelected;
  final VoidCallback onTap;

  const CustomPackage({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? gridHomeColor : Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          width: double.maxFinite,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                    color: faceBookColor,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Duration: $text3',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Number: $text5',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Price: $text4',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
