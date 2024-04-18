import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/registered_home_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class DiagnosticResultScreen extends StatefulWidget {
  const DiagnosticResultScreen({super.key});

  @override
  State<DiagnosticResultScreen> createState() => _DiagnosticResultScreenState();
}

class _DiagnosticResultScreenState extends State<DiagnosticResultScreen> {
  bool showRecommendation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Result"),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: gridHomeColor,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quizes",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
                Text(
                  "ADf",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Other containers representing quiz information
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: gridHomeColor,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Score",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
                Text(
                  "5",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: gridHomeColor,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total questions",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
                Text(
                  "10",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: gridHomeColor,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "correct questions",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
                Text(
                  "6",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: gridHomeColor,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wrong questions",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
                Text(
                  "0",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
            onPressed: () {
              setState(() {
                showRecommendation = !showRecommendation;
              });
            },
            child: const Text(
              "Recommended",
              style: TextStyle(color: Colors.white),
            ),
          ),
          if (showRecommendation) ...[
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Chapter 1",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: faceBookColor)),
                  onPressed: () {
                    const ScaffoldMessenger(
                        child: SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              "Done",
                              style: TextStyle(color: Colors.white),
                            )));
                    // Action for the first elevated button
                  },
                  child: const Text(
                    "Buy",
                    style: TextStyle(
                      color: faceBookColor,
                    ),
                  ),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: faceBookColor),
                  onPressed: () {
                    // Action for the second elevated button
                    const ScaffoldMessenger(
                        child: SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              "Done",
                              style: TextStyle(color: Colors.white),
                            )));
                  },
                  child: const Text(
                    "Buy All",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: faceBookColor),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisteredHomeScreen(),
                    ),);
              },
              child: const Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
