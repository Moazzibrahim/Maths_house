// ignore_for_file: library_private_types_in_public_api, camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/View/widgets/custom_package.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/package/package_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LivePackageDetails extends StatefulWidget {
  const LivePackageDetails({super.key});

  @override
  _livePackageDetailsState createState() => _livePackageDetailsState();
}

class _livePackageDetailsState extends State<LivePackageDetails> {
  int selectedIndex = -1;

  @override
  void initState() {
    Provider.of<PackageProvider>(context, listen: false)
        .fetchlive(context)
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
          appBar: buildAppBar(context, 'Live Package details'),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: packageProvider.alllivepackage.length,
                  itemBuilder: (context, index) {
                    final live = packageProvider.alllivepackage[index];
                    return CustomPackage(
                      text1: live.name,
                      text2: live.module,
                      text3: live.duration.toString(),
                      text4: live.price.toString(),
                      text5: live.number.toString(),
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
                                    .alllivepackage[selectedIndex].id,
                                type: packageProvider
                                    .alllivepackage[selectedIndex].type,
                                chapterName: packageProvider
                                    .alllivepackage[selectedIndex].name,
                                price: packageProvider
                                    .alllivepackage[selectedIndex].price,
                                duration: packageProvider
                                    .alllivepackage[selectedIndex].duration,
                              )),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: faceBookColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.w,
                    horizontal: 120.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Pay Now',
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
