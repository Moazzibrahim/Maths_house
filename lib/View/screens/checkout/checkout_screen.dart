// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/checkout/payment_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final double? price;
  final String? duration;
  final int? discount;
  final String? chapterName;
  final Map<String, dynamic>? examresults;
  const CheckoutScreen({
    super.key,
    this.price,
    this.duration,
    this.discount,
    this.chapterName,
    this.examresults,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String couponCode = "";
  String? chapterName;
  String? duration;
  double? price;
  int? discount;

  @override
  void initState() {
    super.initState();
    // fetchExamResults(context).then((data) {
    //   if (data.isNotEmpty) {
    //     setState(() {
    //       chapterName = data['chapterName'];
    //       duration = data['duration'];
    //       price = data['price'];
    //       discount = data['discount'];
    //     });
    //   } else {
    //     print('Exam results are empty or invalid');
    //   }
    // }).catchError((error) {
    //   print('Error fetching exam results: $error');
    // });
  }

  Future<Map<String, dynamic>> fetchExamResults(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    final response = await http.get(
      Uri.parse(
          'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam_grade'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response body
      Map<String, dynamic> data = json.decode(response.body);
      // Check if the necessary data exists in the response
      if (data.containsKey('chapters') && data['chapters'].isNotEmpty) {
        // Assuming the first chapter contains the desired data
        Map<String, dynamic> firstChapter = data['chapters'][0];
        Map<String, dynamic>? apiLesson = firstChapter['api_lesson'];
        Map<String, dynamic>? apiChapter = apiLesson?['api_chapter'];
        List<dynamic>? priceList = apiChapter?['price'];
        // Check if all required fields are present
        if (apiChapter != null && priceList != null && priceList.isNotEmpty) {
          return {
            'chapterName': apiChapter['chapter_name'],
            'duration': priceList[0]['duration'],
            'price': priceList[0]['price'].toDouble(),
            'discount': priceList[0]['discount'],
          };
        }
      }
      // If the necessary data is not present, return an empty map
      return {};
    } else {
      // If the request fails, return an empty map
      // If the request fails, print the response body and throw an error
      print('Failed to fetch exam results. Response body: ${response.body}');
      throw Exception('Failed to fetch exam results');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      appBar: buildAppBar(context, "Checkout"),
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Container(
                  decoration: const BoxDecoration(color: gridHomeColor),
                  child: Column(
                    children: [
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("product",
                              style: TextStyle(color: faceBookColor)),
                          SizedBox(width: 13.w),
                          const Text("Price",
                              style: TextStyle(color: faceBookColor)),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("chapter 23",
                              style: TextStyle(color: Colors.grey)),
                          SizedBox(width: 13.w),
                          const Text("100",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Chapter 2",
                              style: TextStyle(color: Colors.grey)),
                          SizedBox(width: 13.w),
                          const Text("22.92\$",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.only(left: 18.w, bottom: 18.h),
                        child: Row(
                          children: [
                            const Text("Total: ",
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 8.w),
                            const Text("37.85\$",
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 24.w),
                            const Text(
                              "43\$",
                              style: TextStyle(
                                color: faceBookColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            const Text(
                              "40% off",
                              style: TextStyle(
                                color: faceBookColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Do you have a discount code?"),
                ],
              ),
              SizedBox(height: 14.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: faceBookColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(10.w),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          couponCode =
                              value; // Update the coupon code when text changes
                        },
                        decoration: const InputDecoration(
                          hintText: "Discount code",
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      padding: EdgeInsets.all(4.w),
                      color: gridHomeColor,
                      child: TextButton(
                        onPressed: () {
                          // Add your apply button functionality here using the couponCode variable
                          print("Applied coupon code: $couponCode");
                        },
                        child: Text(
                          "Apply",
                          style:
                              TextStyle(color: faceBookColor, fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 17.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: faceBookColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 130.w,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.w)),
                ),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
