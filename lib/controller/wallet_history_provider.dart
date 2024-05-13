import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/Model/wallet_history_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class WalletProvider with ChangeNotifier {
  List<WalletHistory> walletHistoryList = [];
  String totalWallet = ''; // Define totalWallet property

  Future<void> fetchWalletHistory(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/student_hestory_wallet'), // Replace with your API endpoint
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        WalletHistoryList historyList =
            WalletHistoryList.fromJson(responseData);
        walletHistoryList = historyList.walletHistoryList;
        totalWallet = responseData['totalWallet'];
        print(totalWallet);

        print(walletHistoryList);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('error: $e');
    }
  }
}
