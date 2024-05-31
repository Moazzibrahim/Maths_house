// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/checkout/order_details_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/payment_method_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;

class PaymentScreen extends StatefulWidget {
  final int? id;
  final double? price;
  final String? type;
  final int? duration;

  const PaymentScreen({
    super.key,
    this.id,
    this.price,
    this.type,
    this.duration,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? _selectedOptionId;
  File? _image;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestPermissions();

    Provider.of<PaymentProvider>(context, listen: false)
        .fetchPaymentMethods(context)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> requestPermissions() async {
    var cameraStatus = await Permission.camera.request();
    var storageStatus = await Permission.storage.request();

    if (cameraStatus.isGranted && storageStatus.isGranted) {
      // Permissions granted
    } else {
      // Handle permissions not granted
    }
  }

  Future<void> _uploadFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print('Image selected from gallery: ${_image!.path}');
      });
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      // Decode the image from the file
      img.Image? originalImage = img.decodeImage(imageFile.readAsBytesSync());

      // Resize the image to a width of 800 pixels, maintaining the aspect ratio
      img.Image resizedImage = img.copyResize(originalImage!, width: 800);

      // Compress the resized image
      final File resizedFile = File(imageFile.path)
        ..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 85));

      setState(() {
        _image = resizedFile;
      });

      print('Image taken from camera and resized: ${_image!.path}');
    }
  }

  Future<void> submitPayment(
      int id,
      double price,
      String type,
      int selectedOptionId,
      File imageFile,
      String payment,
      int duration) async {
    try {
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/request_payment_method'));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';

      request.fields['id'] = id.toString();
      request.fields['price'] = price.toString();
      request.fields['type'] = type;
      request.fields['payment_method_id'] = selectedOptionId.toString();
      request.fields['payment'] = payment;
      request.fields['duration'] = duration.toString();

      var multipartFile =
          await http.MultipartFile.fromPath('image', imageFile.path);
      request.files.add(multipartFile);

      print('Sending request with image: ${imageFile.path}');
      var response = await request.send();

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Text("Your operation is pending"),
            );
          },
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrderDetails()),
          );
        });
      } else {
        var responseBody = await response.stream.bytesToString();
        var statusCode = response.statusCode;
        print('Error Response Status Code: $statusCode');
        print("Error Response Body: $responseBody");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text("Failed to make payment. Error: $statusCode"),
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
                        value: paymentMethod.id,
                        groupValue: _selectedOptionId,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedOptionId = value;
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
                    if (_selectedOptionId != null && _image != null) {
                      submitPayment(
                        widget.id!,
                        widget.price!,
                        widget.type!,
                        _selectedOptionId!,
                        _image!,
                        _textFieldController.text,
                        widget.duration!,
                      );
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
                    'Submit',
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
