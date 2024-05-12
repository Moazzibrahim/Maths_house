// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/Model/payment_method_model.dart';
import 'package:http/http.dart' as http; 
import 'package:provider/provider.dart';

class PaymentProvider with ChangeNotifier {
  List<PaymentMethod> allPaymentMethods = [];
  int? selectedPaymentMethodId; // Property to store the selected payment method ID

  Future<void> fetchPaymentMethods(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_payment_methods'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        PaymentMethodList paymentMethodList =
            PaymentMethodList.fromJson(responseData);
        allPaymentMethods = paymentMethodList.paymentMethodList;

        // Accessing id of each payment method
        for (var paymentMethod in allPaymentMethods) {
          int id = paymentMethod.id;
          // Do whatever you want with the id here
          print('Payment method ID: $id');
        }
        
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
