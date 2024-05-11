import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/exam_package_details.dart';
import 'package:flutter_application_1/View/screens/live_package_details.dart';
import 'package:flutter_application_1/View/screens/question_package_details.dart';
import 'package:flutter_application_1/View/widgets/unregistered_profile.dart';
import 'package:flutter_application_1/constants/colors.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({
    super.key,
    required this.isLoggedIn,
  });
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "package",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        automaticallyImplyLeading: false,
      ),
      body: !isLoggedIn
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: gridHomeColor,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(
                          child: Text(
                            'Question:',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: faceBookColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 3,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const QuestionPackageScreen(
                                        key: Key('value'),
                                      )),
                            );
                            // Button onPressed action
                          },
                          child: const Text(
                            'View',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: gridHomeColor,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(
                          child: Text(
                            'Exams:',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: faceBookColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 3,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ExamPackageDetails()),
                            );
                            // Button onPressed action
                          },
                          child: const Text(
                            'View',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: gridHomeColor,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(
                          child: Text(
                            'Live:',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: faceBookColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 3,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LivePackageDetails()),
                            );
                            // Button onPressed action
                          },
                          child: const Text(
                            'View',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const UnregisteredProfile(
              text: 'Login to see your package',
            ),
    );
  }
}
