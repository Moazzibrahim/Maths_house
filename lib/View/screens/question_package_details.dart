// ignore_for_file: use_super_parameters, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/View/widgets/custom_package.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/package/package_provider.dart';
import 'package:provider/provider.dart';

class QuestionPackageScreen extends StatefulWidget {
  const QuestionPackageScreen({Key? key}) : super(key: key);

  @override
  _QuestionPackageScreenState createState() => _QuestionPackageScreenState();
}

class _QuestionPackageScreenState extends State<QuestionPackageScreen> {
  int selectedIndex = -1;

  @override
  void initState() {
    Provider.of<PackageProvider>(context, listen: false)
        .fetchQuestion(context)
        .catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PackageProvider>(
      builder: (context, packageProvider, _) {
        return Scaffold(
          appBar: buildAppBar(context, 'Question Package details'),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: packageProvider.allquestionpackage.length,
                  itemBuilder: (context, index) {
                    final question = packageProvider.allquestionpackage[index];
                    return CustomPackage(
                      text1: question.name,
                      text2: question.module,
                      text3: question.duration.toString(),
                      text4: question.price.toString(),
                      text5: question.number.toString(),
                      isSelected: selectedIndex == index,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedIndex != -1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                                id: packageProvider
                                    .allquestionpackage[selectedIndex].id,
                                type: packageProvider
                                    .allquestionpackage[selectedIndex].type,
                                chapterName: packageProvider
                                    .allquestionpackage[selectedIndex].name,
                                price: packageProvider
                                    .allquestionpackage[selectedIndex].price,
                                duration: packageProvider
                                    .allquestionpackage[selectedIndex].duration,
                              )),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: faceBookColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 140,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
