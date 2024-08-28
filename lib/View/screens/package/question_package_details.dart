// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/View/widgets/custom_package.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/package/package_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionPackageScreen extends StatefulWidget {
  const QuestionPackageScreen({super.key});

  @override
  _QuestionPackageScreenState createState() => _QuestionPackageScreenState();
}

class _QuestionPackageScreenState extends State<QuestionPackageScreen> {
  int selectedIndex = -1;
  int? selectedCourseId;

  @override
  void initState() {
    super.initState();
    final packageProvider =
        Provider.of<PackageProvider>(context, listen: false);
    packageProvider.fetchQuestionPackages(context).catchError((e) {
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
          appBar: buildAppBar(context, 'Question Package Details'),
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
                    color: gridHomeColor, // Background color
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
                          fontSize: 16.sp, // Adjust font size
                          fontWeight: FontWeight.w500, // Font weight
                        ),
                      ),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedCourseId = newValue;
                          if (newValue != null) {
                            packageProvider.filterPackagesByCourseId(newValue);
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: faceBookColor, // Icon color
                      ),
                      isExpanded: true, // Makes the dropdown fill the width
                      items: packageProvider.allCourses.map((course) {
                        return DropdownMenuItem<int>(
                          value: course.id,
                          child: Text(
                            course.courseName,
                            style: TextStyle(
                              fontSize: 16.sp, // Adjust font size
                              color: Colors.black87, // Text color
                              fontWeight: FontWeight.w500, // Font weight
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              // Display question package list only if a course is selected
              if (selectedCourseId != null)
                Expanded(
                  child: packageProvider.filteredPackages.isNotEmpty
                      ? ListView.builder(
                          itemCount: packageProvider.filteredPackages.length,
                          itemBuilder: (context, index) {
                            final questionPackage =
                                packageProvider.filteredPackages[index];
                            return CustomPackage(
                              text1: questionPackage.name,
                              text2: questionPackage.module,
                              text3: questionPackage.duration.toString(),
                              text4: questionPackage.price.toString(),
                              text5: questionPackage.number.toString(),
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
                              'No question packages available for the selected course')),
                )
              else
                const Expanded(
                  child: Center(
                      child: Text(
                          'Please select a course to see question packages')),
                ),
              // Button to proceed to checkout
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedIndex != -1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            id: packageProvider
                                .filteredPackages[selectedIndex].id,
                            type: packageProvider
                                .filteredPackages[selectedIndex].type,
                            chapterName: packageProvider
                                .filteredPackages[selectedIndex].name,
                            price: packageProvider
                                .filteredPackages[selectedIndex].price,
                            duration: packageProvider
                                .filteredPackages[selectedIndex].duration,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: faceBookColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 140.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
