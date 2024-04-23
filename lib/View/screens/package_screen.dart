import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/exam_package_details.dart';
import 'package:flutter_application_1/View/screens/live_package_details.dart';
import 'package:flutter_application_1/View/widgets/unregistered_profile.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({
    super.key,
    required this.isLoggedIn,
  });
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Package'),
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
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            style: TextStyle(),
                            maxLines: 1,
                            '#Package:33',
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
                            'exams:',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            style: TextStyle(),
                            maxLines: 1,
                            '#Package: 1',
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
                            'live:',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            style: TextStyle(),
                            maxLines: 1,
                            '#Package: 9',
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
                                      const livePackageDetails()),
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
