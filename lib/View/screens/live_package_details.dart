import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/checkout_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class livePackageDetails extends StatefulWidget {
  const livePackageDetails({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _livePackageDetailsState createState() => _livePackageDetailsState();
}

class _livePackageDetailsState extends State<livePackageDetails> {
  List<bool> isSelected = [false, false, false];

  void selectContainer(int index) {
    setState(() {
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = i == index;
      }
    });
  }

  void resetSelection() {
    setState(() {
      isSelected = [false, false, false];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Package details'),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            const Row(
              children: [
                Text(
                  'Live',
                  style: TextStyle(fontSize: 22, color: faceBookColor),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () => selectContainer(0),
                child: Container(
                  decoration: BoxDecoration(
                      color: isSelected[0] ? gridHomeColor : Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  width: double.maxFinite,
                  height: 100,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Package #1',
                        style: TextStyle(color: faceBookColor, fontSize: 20),
                      ),
                      Text(
                        'Duration:60 days',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      Text(
                        'price:165\$',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => selectContainer(1),
              child: Container(
                width: double.maxFinite,
                height: 100,
                color: isSelected[1] ? gridHomeColor : Colors.white,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Package #2',
                      style: TextStyle(color: faceBookColor, fontSize: 20),
                    ),
                    Text(
                      'Duration:60 days',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    Text(
                      'price:165\$',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () => selectContainer(2),
                child: Container(
                  width: double.maxFinite,
                  height: 100,
                  color: isSelected[2] ? gridHomeColor : Colors.white,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Package #3',
                        style: TextStyle(color: faceBookColor, fontSize: 20),
                      ),
                      Text(
                        'Duration:60 days',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      Text(
                        'price:165\$',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CheckoutScreen()),
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
                'Pay Now',
                style: TextStyle(
                    fontSize: 18,
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
