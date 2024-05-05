import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/widgets/custom_package.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/package/package_provider.dart';
import 'package:provider/provider.dart';

class livePackageDetails extends StatefulWidget {
  const livePackageDetails({Key? key}) : super(key: key);

  @override
  _livePackageDetailsState createState() => _livePackageDetailsState();
}

class _livePackageDetailsState extends State<livePackageDetails> {
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
          appBar: buildAppBar(context, 'Package details'),
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
                    // Perform action with selected item
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
