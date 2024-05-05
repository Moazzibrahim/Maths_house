import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/checkout/order_details_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedOption;
  File? _image;

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
  Widget build(BuildContext context) {
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
              ListTile(
                title: const Text(
                  'visa',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                leading: Radio<String>(
                  activeColor: faceBookColor,
                  value: 'visa',
                  groupValue: _selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
                tileColor: _selectedOption == 'visa' ? gridHomeColor : null,
                onTap: () {
                  setState(() {
                    _selectedOption = 'visa';
                  });
                },
              ),
              ListTile(
                title: const Text('Binance'),
                leading: Radio<String>(
                  activeColor: faceBookColor,
                  value: 'Binance',
                  groupValue: _selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
                tileColor: _selectedOption == 'Binance' ? gridHomeColor : null,
                onTap: () {
                  setState(() {
                    _selectedOption = 'Binance';
                  });
                },
              ),
              ListTile(
                title: const Text('Skrill'),
                leading: Radio<String>(
                  activeColor: faceBookColor,
                  value: 'Skrill',
                  groupValue: _selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
                tileColor: _selectedOption == 'Skrill' ? gridHomeColor : null,
                onTap: () {
                  setState(() {
                    _selectedOption = 'Skrill';
                  });
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Image.asset('assets/images/vodafone_icon 1.png'),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('Vodafone Cash')
                  ],
                ),
                leading: Radio<String>(
                  activeColor: faceBookColor,
                  value: 'Vodafone Cash',
                  groupValue: _selectedOption,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
                tileColor:
                    _selectedOption == 'Vodafone Cash' ? gridHomeColor : null,
                onTap: () {
                  setState(() {
                    _selectedOption = 'Vodafone Cash';
                  });
                },
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
  }
}
