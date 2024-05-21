// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/checkout/payment_screen.dart';
import 'package:flutter_application_1/View/screens/wallet_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final double? price;
  final String? duration;
  final double? discount;
  final String? chapterName;
  final int? id;
  final String? type;
  final Map<String, dynamic>? examresults;

  const CheckoutScreen({
    super.key,
    this.price,
    this.duration,
    this.discount,
    this.chapterName,
    this.examresults,
    this.id,
    this.type,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String couponCode = "";
  double? updatedPrice;
  double? discountPercentage;

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
                          Text("${widget.chapterName}",
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
                          // Add your apply button functionality here using the couponCode variable
                          print("Applied coupon code: $couponCode");

                          try {
                            final tokenProvider =
                                Provider.of<TokenModel>(context, listen: false);
                            final token = tokenProvider.token;

                            // Construct the URL
                            final url =
                                'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/checkOut_payment_method/$couponCode/${widget.type}/${widget.id}';

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
                              setState(() {
                                updatedPrice = newPrice.toDouble();
                                discountPercentage =
                                    ((widget.price! - updatedPrice!) /
                                            widget.price!) *
                                        100;
                              });
                              print('Coupon applied successfully');
                            } else {
                              // Handle failure response
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
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text("Using wallet or payment methods?"),
                        actions: [
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: faceBookColor,
                                ),
                                onPressed: () async {
                                  try {
                                    final tokenProvider =
                                        Provider.of<TokenModel>(context,
                                            listen: false);
                                    final token = tokenProvider.token;

                                    final response = await http.post(
                                      Uri.parse(
                                          'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_payment_wallet'),
                                      headers: {
                                        'Content-Type': 'application/json',
                                        'Accept': 'application/json',
                                        'Authorization': 'Bearer $token',
                                      },
                                      body: json.encode({
                                        'id': widget.id,
                                        'type': widget.type,
                                        'price': updatedPrice,
                                      }),
                                    );

                                    if (response.statusCode == 200) {
                                      print(response.body);
                                      // Handle success response
                                      print('Data sent successfully');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const WalletScreen(),
                                        ),
                                      );
                                    } else {
                                      // Handle failure response
                                      print(
                                          'Failed to send data. Status code: ${response.statusCode}');
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Payment Failed'),
                                          content: const Text(
                                              'Failed to process payment. Please try again later.'),
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
                                  } catch (error) {
                                    // Handle any exceptions
                                    print('Error: $error');
                                  }
                                },
                                child: const Text(
                                  "wallet",
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentScreen(
                                        id: widget.id,
                                        price: updatedPrice,
                                        type: widget.type,
                                      ),
                                    ),
                                  );
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
    );
  }
}
