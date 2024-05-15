import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/Model/payment_history_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class PaymentHistoryProvider with ChangeNotifier {
  List<PaymentHistory> paymentHistoryList = [];

  Future<void> fetchPaymentHistory(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/payment_request_hestory'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        PaymentHistoryList historyList =
            PaymentHistoryList.fromJson(responseData);
        paymentHistoryList = historyList.paymentHistoryList;
        print(paymentHistoryList);
        notifyListeners();
      } else {
        print(e);
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('error: $e');
    }
  }
}
