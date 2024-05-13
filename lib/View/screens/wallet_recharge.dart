// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/checkout/order_details_screen.dart';
import 'package:flutter_application_1/View/screens/registered_home_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/payment_method_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class WalletRechargeScreen extends StatefulWidget {
  const WalletRechargeScreen({super.key});

  @override
  _WalletRechargeScreenState createState() => _WalletRechargeScreenState();
}

class _WalletRechargeScreenState extends State<WalletRechargeScreen> {
  int? _selectedOptionId; // Variable to store the selected payment method ID
  File? _image;
  final TextEditingController _textFieldController = TextEditingController();

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

  Future<void> submitPayment(
      int selectedOptionId, File imageFile, String wallet) async {
    try {
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;
      final paymentMethodProvider =
          Provider.of<PaymentProvider>(context, listen: false);
      final paymentMethodId = paymentMethodProvider.selectedPaymentMethodId;
      final loginModel = Provider.of<LoginModel>(context, listen: false);
      final studentId = loginModel.id;
      wallet = _textFieldController.text;
      // Prepare the request
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/proccess_student_wallet'));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['student_id'] = studentId.toString();
      request.fields['wallet'] = wallet;
      request.fields['payment_method_id'] = selectedOptionId.toString();

      // Attach the image
      var imageUri = Uri.parse('file://${imageFile.path}');
      var multipartFile =
          await http.MultipartFile.fromPath('image', imageUri.path);
      request.files.add(multipartFile);

      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        // Show an alert dialog with "Successful Payment" text
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Text("Your operation is pending"),
            );
          },
        );
        // Delay navigation to the order details screen by 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrderDetails()),
          );
        });
      } else {
        // Handle the error response
        var responseBody = await response.stream.bytesToString();
        var statusCode = response.statusCode;
        print('Error Response Status Code: $statusCode');
        var error = jsonDecode(responseBody);
        print("$error");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Failed to make payment"),
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
    } catch (e) {
      // Handle any exceptions
      print("Error: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text(
                "An unexpected error occurred. Please try again later."),
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
                      leading: Radio<int>(
                        activeColor: faceBookColor,
                        value: paymentMethod.id, // Use int value
                        groupValue:
                            _selectedOptionId ?? 0, // Use selectedOptionId
                        onChanged: (int? value) {
                          setState(() {
                            _selectedOptionId =
                                value; // Update selectedOptionId
                          });
                        },
                      ),
                      tileColor: _selectedOptionId == paymentMethod.id
                          ? gridHomeColor
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedOptionId = paymentMethod.id;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(
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
                    // Before sending the request, check if _selectedOptionId is not null
                    if (_selectedOptionId != null) {
                      // Call the submitPayment method with the selected option
                      submitPayment(_selectedOptionId!, _image!,
                          _textFieldController.text);
                    } else {
                      // Display an error message to the user
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content:
                                const Text("Please select a payment method."),
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
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(
                          120)), // Adjust the top padding based on screen height
                  child: Center(
                    child: Container(
                      width: ScreenUtil().setWidth(
                          200), // Adjust the width based on screen width
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(10)),
                        color: gridHomeColor,
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisteredHomeScreen()),
                          );
                        },
                        icon: const Icon(
                          Icons.home,
                          color: faceBookColor,
                        ),
                        label: const Text(
                          'home',
                          style: TextStyle(color: faceBookColor),
                        ),
                      ),
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
