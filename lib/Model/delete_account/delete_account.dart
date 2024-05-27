import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:provider/provider.dart'; // Import Provider

class DeleteAccount with ChangeNotifier {
  Future<void> deleteAccount(BuildContext context) async {
    try {
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;
      final response = await http.post(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/delete_account'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        log('Deleted account successful');
        log(response.body);
        log("$token");
      } else {
        log('Delete account failed');
        log('Status code: ${response.statusCode}');
        log('Response body: ${response.body}');
      }
    } catch (error) {
      log('Error: $error');
    }
  }
}
