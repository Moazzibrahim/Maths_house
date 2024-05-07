import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/View/widgets/custom_package.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/package/package_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamPackageDetails extends StatefulWidget {
  const ExamPackageDetails({Key? key}) : super(key: key);

  @override
  _ExamPackageDetailsState createState() => _ExamPackageDetailsState();
}

class _ExamPackageDetailsState extends State<ExamPackageDetails> {
  int selectedIndex = -1;

  @override
  void initState() {
    Provider.of<PackageProvider>(context, listen: false)
        .fetchexam(context)
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
          appBar: buildAppBar(context, 'Exam Package details'),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: packageProvider.allexamspackage.length,
                  itemBuilder: (context, index) {
                    final exam = packageProvider.allexamspackage[index];
                    return CustomPackage(
                      text1: exam.name,
                      text2: exam.module,
                      text3: exam.duration.toString(),
                      text4: exam.price.toString(),
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
                                chapterName: packageProvider
                                    .allquestionpackage[selectedIndex].name,
                                price: packageProvider
                                    .allquestionpackage[selectedIndex].price,
                              )),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: faceBookColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.w,
                    horizontal: 140.w,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Pay Now',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
