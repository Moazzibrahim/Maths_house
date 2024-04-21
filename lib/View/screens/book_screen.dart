import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/View/screens/checkout/order_details_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Package'),
      body: CustomPackage(),
    );
  }
}

class CustomPackage extends StatelessWidget {
  const CustomPackage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: gridHomeColor, borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    'Question:',
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    style: TextStyle(),
                    maxLines: 1,
                    '#Package:3',
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: faceBookColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderDetails()),
                      );
                      // Button onPressed action
                    },
                    child: Text(
                      'View',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: gridHomeColor, borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    'Exams:',
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    '#Package:1',
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: faceBookColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderDetails()),
                      );
                      // Button onPressed action
                    },
                    child: Text(
                      'View',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: gridHomeColor, borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    'Live:',
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    '#Package:3',
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: faceBookColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderDetails()),
                      );
                      // Button onPressed action
                    },
                    child: Text(
                      'View',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
