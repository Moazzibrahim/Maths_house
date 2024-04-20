import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutscreenState();
}

class _CheckoutscreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Checkout"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: const BoxDecoration(color: gridHomeColor),
                child: const Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "product",
                          style: TextStyle(color: faceBookColor),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        Text(
                          "Price",
                          style: TextStyle(color: faceBookColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Chapter 1:",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        Text("18.92\$", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Chapter 2:",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        Text(
                          "22.92\$",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 18,
                        bottom: 18,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Total: ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "37.85\$",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Text(
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
            const SizedBox(
              height: 12,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Do you have a discount code?",
                ),
              ],
            ),
          const  SizedBox(
              height: 14,
            )
          ],
        ),
      ),
    );
  }
}
