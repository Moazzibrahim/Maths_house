import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUnregisteredWidgets extends StatelessWidget {
  const CustomUnregisteredWidgets({super.key, required this.text,required this.image});
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 7.w,
                          vertical: 15.h,
                        ),
                        height: 130.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          height: 130.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.4)
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  text,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                        ),
                        );
  }
}