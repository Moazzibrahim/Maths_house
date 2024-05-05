import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/registered_home_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("order details"),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisteredHomeScreen()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: faceBookColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 150,
                decoration: const BoxDecoration(color: gridHomeColor),
                child: const Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Order number:",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 100),
                            child: Text(
                              "#258",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "date:",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 145),
                            child: Text("2/4/2024",
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "total:",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 160),
                            child: Text(
                              "34\$",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            "payment method:",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 80),
                            child: Text("visa",
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisteredHomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: faceBookColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 140,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text(
                'Back home',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
