// ignore_for_file: avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/checkout/payment_chapter_screen.dart';
import 'package:flutter_application_1/View/screens/wallet_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CheckoutChapterScreen extends StatefulWidget {
  final double? price;
  final List<int>? duration;
  final double? discount;
  final String? chapterName;
  final List<int>? id;
  final String? type;
  final int? courseid;
  final Map<String, dynamic>? examresults;

  const CheckoutChapterScreen({
    super.key,
    this.price,
    this.duration,
    this.discount,
    this.chapterName,
    this.examresults,
    this.id,
    this.type,
    this.courseid,
  });

  @override
  State<CheckoutChapterScreen> createState() => _CheckoutChapterScreenState();
}

class _CheckoutChapterScreenState extends State<CheckoutChapterScreen> {
  String couponCode = "";
  double? updatedPrice;
  double? discountPercentage;
  List<Map<String, dynamic>> chapters = []; // List to store chapter details

  @override
  void initState() {
    super.initState();
    updatedPrice = widget.price;
    if (widget.price != null && widget.discount != null && widget.price! > 0) {
      discountPercentage =
          ((widget.price! - updatedPrice!) / widget.price!) * 100;
    } else {
      discountPercentage = 0;
    }

    if (widget.chapterName != null &&
        widget.id != null &&
        widget.price != null) {
      for (int i = 0; i < widget.id!.length; i++) {
        chapters.add({
          'chapterName': widget.chapterName,
          'id': widget.id![i],
          'price': widget.price,
          'duration': widget.duration!,
        });
      }
    } else {
      discountPercentage = 0;
    }
  }

  // Helper function to get filtered id and duration lists
  Map<String, List<int>> getFilteredLists() {
    List<int> filteredId = [];
    List<int> filteredDuration = [];

    if (widget.duration != null && widget.id != null) {
      for (int i = 0; i < widget.duration!.length; i++) {
        if (widget.duration![i] != 0) {
          filteredId.add(widget.id![i]);
          filteredDuration.add(widget.duration![i]);
        }
      }
    }

    return {
      'filteredId': filteredId,
      'filteredDuration': filteredDuration,
    };
  }

  Future<void> handleWalletPayment(
      List<int> filteredId, List<int> filteredDuration) async {
    try {
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;

      // Print the data being sent to the API
      print('Sending to API:');
      print('ID: $filteredId');
      print('Duration: $filteredDuration');
      print('Type: Chapter');
      print('Price: $updatedPrice');

      final response = await http.post(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_payment_wallet'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'id': filteredId,
          'duration': filteredDuration,
          'type': 'Chapter',
          'price': updatedPrice,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success response
        print('Payment successful');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Your Operation is done'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalletScreen(),
          ),
        );
        // Navigate to another screen or show a success message
      } else {
        // Handle failure response
        print('Payment failed. Status code: ${response.statusCode}');
        print(response.body);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Payment Failed'),
            content: const Text('Failed to process payment. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Handle any exceptions
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return WillPopScope(
      onWillPop: () async {
        return Future.value(false); // Prevent back navigation
      },
      child: Scaffold(
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
                            const Text("Product",
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
                            Text("${widget.type}",
                                style: const TextStyle(color: Colors.grey)),
                            SizedBox(width: 13.w),
                            Text("$updatedPrice",
                                style: const TextStyle(color: Colors.grey)),
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
                              Text("$updatedPrice",
                                  style: const TextStyle(color: Colors.grey)),
                              SizedBox(width: 24.w),
                              Text(
                                "${discountPercentage?.toStringAsFixed(0)}% off",
                                style: const TextStyle(
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
                          onPressed: () async {
                            print("Applied coupon code: $couponCode");
                            try {
                              final tokenProvider = Provider.of<TokenModel>(
                                  context,
                                  listen: false);
                              final token = tokenProvider.token;

                              // Get filtered lists
                              final filteredLists = getFilteredLists();
                              final filteredId = filteredLists['filteredId'];

                              // Construct the URL with type set to "chapters"
                              final url =
                                  'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/check_promo_chapter/${widget.type}/${filteredId}/${widget.price}/$couponCode/${widget.courseid}';

                              // Print the URL being sent
                              print('Sending URL: $url');

                              final response = await http.get(
                                Uri.parse(url),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Accept': 'application/json',
                                  'Authorization': 'Bearer $token',
                                },
                              );

                              if (response.statusCode == 200) {
                                // Handle success response
                                final responseData = json.decode(response.body);
                                final newPrice = responseData['newPrice'];

                                if (newPrice != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Your Coupon applied successfully'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  setState(() {
                                    updatedPrice = newPrice.toDouble();
                                    discountPercentage =
                                        ((widget.price! - updatedPrice!) /
                                                widget.price!) *
                                            100;
                                  });
                                  print('Coupon applied successfully');
                                  print(response.body);
                                } else {
                                  // Show message if newPrice is null
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                          'Coupon Application Failed'),
                                      content: const Text(
                                          "This Chapter Don't Have Promo Code"),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                print(response.body);
                                print(
                                    'Failed to apply coupon. Status code: ${response.statusCode}');
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title:
                                        const Text('Coupon Application Failed'),
                                    content: const Text(
                                        'Failed to apply coupon. Please try again.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            } catch (error) {
                              // Handle any exceptions
                              print('Error: $error');
                            }
                          },
                          child: Text(
                            "Apply",
                            style: TextStyle(
                                color: faceBookColor, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 17.h),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content:
                              const Text("Using wallet or payment methods?"),
                          actions: [
                            Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: faceBookColor,
                                  ),
                                  onPressed: () async {
                                    // Get filtered lists
                                    final filteredLists = getFilteredLists();
                                    final filteredId =
                                        filteredLists['filteredId']!;
                                    final filteredDuration =
                                        filteredLists['filteredDuration']!;

                                    if (filteredDuration.isNotEmpty) {
                                      await handleWalletPayment(
                                          filteredId, filteredDuration);
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Error"),
                                            content: const Text(
                                                "Duration list is invalid."),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Wallet",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: faceBookColor,
                                  ),
                                  onPressed: () {
                                    // Get filtered lists
                                    final filteredLists = getFilteredLists();
                                    final filteredId =
                                        filteredLists['filteredId']!;
                                    final filteredDuration =
                                        filteredLists['filteredDuration']!;

                                    if (filteredDuration.isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentChapterScreen(
                                            id: filteredId,
                                            price: updatedPrice,
                                            duration: filteredDuration,
                                          ),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Error"),
                                            content: const Text(
                                                "Duration list is invalid."),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Payment methods",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: faceBookColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 120.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.w),
                    ),
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
      ),
    );
  }
}
