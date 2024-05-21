
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/all_courses_model.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseCourseScreen extends StatefulWidget {
  const PurchaseCourseScreen({super.key, required this.course});
  final CoursesCategories course;

  @override
  State<PurchaseCourseScreen> createState() => _PurchaseCourseScreenState();
}

class _PurchaseCourseScreenState extends State<PurchaseCourseScreen> {
  late int selectedDuration;
  List<int> durations = [];
  List<bool> chapterActiveStatus = []; 
  @override
  void initState() {
    final durationsSet = widget.course.coursePrices.map((e) => e.duration).toSet();
    durations = durationsSet.toList();
    log('$durations');
    selectedDuration = durations[0];
    chapterActiveStatus = List<bool>.filled(widget.course.chapterWithPrice.length, true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'course'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                widget.course.courseUrl,
                width: double.infinity,
              ),
              Text(widget.course.courseName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                'course description',
                style: TextStyle(color: Colors.black.withOpacity(0.7)),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.redAccent[700],
                ),
                child: const Text(
                  'Best Seller',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text('4.8'),
                  const SizedBox(
                    width: 5,
                  ),
                  for (int i = 0; i < 4; i++)
                    Icon(
                      Icons.star,
                      size: 14.sp,
                      color: const Color.fromARGB(218, 252, 228, 16),
                    ),
                  SizedBox(
                    width: 5.w,
                  ),
                  const Text('(11,654 Ratings)'),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    'Price: ',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.course.coursePrices[0].price.toString(),
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      const Text('EGP'),
                    ],
                  ),
                  SizedBox(
                    width: 50.w,
                  ),
                  const Text('Select Duration: '),
                  SizedBox(
                    width: 5.w,
                  ),
                  DropdownButton(
                    value: selectedDuration,
                    onChanged: (value) {
                      setState(() {
                        selectedDuration = value!;
                      });
                    },
                    items: durations.map((e){ 
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.toString())
                        );
                      }).toList(),
                    ),
                ],
              ),
              SizedBox(height: 20.h,),
              Container(
                margin: const EdgeInsets.all(8),
                width: double.infinity,
                height: 42.h,
                child: ElevatedButton(
                  onPressed: (){}, 
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: Colors.redAccent[700],
                    foregroundColor: Colors.white,
                  ),
                child: Text('Check Out',style: TextStyle(fontSize: 16.sp),))),
                SizedBox(height: 10.h,),
                const Text('Course Content',style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                Column(
                  children: [
                    for (int i = 0; i < widget.course.chapterWithPrice.length; i++)
                    CheckboxListTile(
                      title: Text(widget.course.chapterWithPrice[i].chapterName),
                      value: chapterActiveStatus[i],
                      activeColor: Colors.redAccent[700],
                      onChanged: (bool? value) {
                        setState(() {
                          chapterActiveStatus[i] = value!;
                        });
                      },
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
