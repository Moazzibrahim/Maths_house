import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/View/screens/checkout/order_details_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late TextEditingController cardnumber;
  late TextEditingController cardholder;
  late TextEditingController expirydate;
  late TextEditingController securitycode;

  @override
  void initState() {
    super.initState();
    cardnumber = TextEditingController();
    cardholder = TextEditingController();
    expirydate = TextEditingController();
    securitycode = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Payment'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Enter Payment Details',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: cardnumber,
                decoration: const InputDecoration(
                  labelText: 'card number',
                ),
              ),
            ),
            TextField(
              controller: cardholder,
              decoration: const InputDecoration(
                labelText: 'card holder',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: expirydate,
                      decoration: const InputDecoration(
                        labelText: 'expiry date',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: securitycode,
                      decoration: const InputDecoration(
                        labelText: 'Security Code',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderDetails()),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Text('or'),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
