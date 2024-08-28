// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/package_model.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/View/widgets/custom_package.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/package/package_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LivePackageDetails extends StatefulWidget {
  const LivePackageDetails({super.key});

  @override
  _livePackageDetailsState createState() => _livePackageDetailsState();
}

// ignore: camel_case_types
class _livePackageDetailsState extends State<LivePackageDetails> {
  int selectedIndex = -1;
  int? selectedCourseId;

  @override
  void initState() {
    super.initState();
    // Fetch data when the screen is initialized
    final packageProvider =
        Provider.of<PackageProvider>(context, listen: false);
    packageProvider.fetchLive(context).catchError((e) {
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
          appBar: buildAppBar(context, 'Live Package details'),
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
                    color: gridHomeColor,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: faceBookColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: selectedCourseId,
                      hint: Text(
                        'Select Course',
                        style: TextStyle(
                          color: faceBookColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedCourseId = newValue;
                          if (newValue != null) {
                            packageProvider
                                .filterLivePackagesByCourseId(newValue);
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: faceBookColor,
                      ),
                      isExpanded: true,
                      items: packageProvider.allCourses.map((Course course) {
                        return DropdownMenuItem<int>(
                          value: course.id,
                          child: Text(
                            course.courseName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              // Display package list only if a course is selected
              if (selectedCourseId != null)
                Expanded(
                  child: packageProvider.filteredLivePackage.isNotEmpty
                      ? ListView.builder(
                          itemCount: packageProvider.filteredLivePackage.length,
                          itemBuilder: (context, index) {
                            final live =
                                packageProvider.filteredLivePackage[index];
                            return CustomPackage(
                              text1: live.name,
                              text2: live.module,
                              text3: live.duration.toString(),
                              text4: live.price.toString(),
                              text5: live.number.toString(),
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
                              'No packages available for the selected course')),
                )
              else
                const Expanded(
                  child: Center(
                      child: Text('Please select a course to see packages')),
                ),
              // Button to proceed to checkout
              ElevatedButton(
                onPressed: () {
                  if (selectedIndex != -1) {
                    final selectedPackage =
                        packageProvider.filteredLivePackage[selectedIndex];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                                id: selectedPackage.id,
                                type: selectedPackage.type,
                                chapterName: selectedPackage.name,
                                price: selectedPackage.price,
                                duration: selectedPackage.duration,
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
