import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/order_details_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/payment_method_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedOption;
  File? _image;
  TextEditingController _textFieldController = TextEditingController();

  Future<void> _uploadFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    Provider.of<PaymentProvider>(context, listen: false)
        .fetchPaymentMethods(context)
        .catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentProvider>(builder: (context, paymentProvider, _) {
      return Scaffold(
        appBar: buildAppBar(context, 'Payment'),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose payment method',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paymentProvider.allPaymentMethods.length,
                  itemBuilder: (context, index) {
                    final paymentMethod =
                        paymentProvider.allPaymentMethods[index];
                    return ListTile(
                      title: Text(
                        paymentMethod.payment,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      leading: Radio<String>(
                        activeColor: faceBookColor,
                        value: paymentMethod.payment,
                        groupValue: _selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                      tileColor: _selectedOption == paymentMethod.payment
                          ? gridHomeColor
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedOption = paymentMethod.payment;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _textFieldController,
                  decoration: InputDecoration(
                    labelText: 'Enter your paid amount',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _image != null
                        ? Image.file(
                            _image!,
                            width: 200,
                            height: 200,
                          )
                        : Text(
                            'Upload receipt',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: faceBookColor,
                            ),
                          ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _uploadFromGallery,
                          child: const Text(
                            'Upload from Gallery',
                            style: TextStyle(color: faceBookColor),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _takePhoto,
                          child: const Text(
                            'Take Photo',
                            style: TextStyle(color: faceBookColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedOption != null && _image != null) {
                      //submitPayment(_selectedOption!, _image!);
                      // Show an alert dialog with "Successful Payment" text
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            // title: Text("Payment Successful"),
                            content: Text("successful payment"),
                          );
                        },
                      );
                      // Delay navigation to the order details screen by 2 seconds
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderDetails()),
                        );
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: const Text(
                                "Please select a payment method and upload a receipt."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: faceBookColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 130.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                  ),
                  child: Text(
                    'submit',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
