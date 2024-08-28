// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/package_model.dart'; // Ensure this includes your Exam model
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart'; // Adjust import as needed
import 'package:flutter_application_1/View/widgets/custom_package.dart'; // Adjust if you need a different widget for exams
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/package/package_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamDetails extends StatefulWidget {
  const ExamDetails({super.key});

  @override
  _ExamDetailsState createState() => _ExamDetailsState();
}

class _ExamDetailsState extends State<ExamDetails> {
  int selectedIndex = -1;
  int? selectedCourseId;

  @override
  void initState() {
    super.initState();
    final packageProvider =
        Provider.of<PackageProvider>(context, listen: false);
    packageProvider.fetchExams(context).catchError((e) {
      print(e);
    });
    packageProvider.fetchCourses(context).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PackageProvider>(
      builder: (context, packageProvider, _) {
        return Scaffold(
          appBar: buildAppBar(context, 'Exam Details'),
          body: Column(
            children: [
              // Dropdown button for selecting a course
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: gridHomeColor, // Replace with your background color
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
                    border: Border.all(color: faceBookColor), // Border color
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: selectedCourseId,
                      hint: Text(
                        'Select Course',
                        style: TextStyle(
                          color: faceBookColor, // Hint text color
                          fontSize: 16.sp, // Text size
                          fontWeight: FontWeight.w500, // Text weight
                        ),
                      ),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedCourseId = newValue;
                          if (newValue != null) {
                            packageProvider.filterExamsByCourseId(newValue);
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: faceBookColor, // Icon color
                      ),
                      isExpanded: true, // Makes the dropdown fill the width
                      items: packageProvider.allCourses.map((Course course) {
                        return DropdownMenuItem<int>(
                          value: course.id,
                          child: Text(
                            course.courseName,
                            style: TextStyle(
                              fontSize: 16.sp, // Text size
                              color: Colors.black87, // Text color
                              fontWeight: FontWeight.w500, // Text weight
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              // Display exam list only if a course is selected
              if (selectedCourseId != null)
                Expanded(
                  child: packageProvider.filteredExams.isNotEmpty
                      ? ListView.builder(
                          itemCount: packageProvider.filteredExams.length,
                          itemBuilder: (context, index) {
                            final exam = packageProvider.filteredExams[index];
                            return CustomPackage(
                              text1: exam.name,
                              text2: exam.module,
                              text3: exam.duration.toString(),
                              text4: exam.price.toString(),
                              text5: exam.number.toString(),
                              isSelected: selectedIndex == index,
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                              'No exams available for the selected course')),
                )
              else
                const Expanded(
                  child: Center(
                      child:
                          Text('Please select a course to see exams package')),
                ),
              // Button to proceed to checkout
              ElevatedButton(
                onPressed: () {
                  if (selectedIndex != -1) {
                    final selectedExam =
                        packageProvider.filteredExams[selectedIndex];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                                id: selectedExam.id,
                                type: selectedExam.type,
                                chapterName: selectedExam.name,
                                price: selectedExam.price,
                                duration: selectedExam.duration,
                              )),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: faceBookColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.w,
                    horizontal: 120.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Pay Now',
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
