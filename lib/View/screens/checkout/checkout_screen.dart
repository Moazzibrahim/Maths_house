import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/payment_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String couponCode = "";

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
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
                          const Text("Price", style: TextStyle(color: faceBookColor))
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Chapter 1:",
                              style: TextStyle(color: Colors.grey)),
                          SizedBox(width: 13.w),
                          const Text("18.92\$", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Chapter 2:",
                              style: TextStyle(color: Colors.grey)),
                          SizedBox(width: 13.w),
                          const Text("22.92\$", style: TextStyle(color: Colors.grey)),
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
                  Text(
                    "Do you have a discount code?",
                  ),
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
                    MaterialPageRoute(
                        builder: (context) => const PaymentScreen()),
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
