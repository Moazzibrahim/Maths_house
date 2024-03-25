// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/registered_home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

// Create a class to hold the token
class TokenModel with ChangeNotifier {
  late String _token;

  String get token => _token;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }
}
// class Idmodel with ChangeNotifier {
//   late String _id = ''; // Initialize _id with an empty string
//   String get id => _id;

//   void setid(String id) {
//     _id = id;
//     notifyListeners();
//   }
// }
class LoginModel with ChangeNotifier {
  Future<String> loginUser(
      BuildContext context, String email, String password) async {
    // API endpoint to authenticate user
    String apiUrl = 'https://login.mathshouse.net/api/login';
    http.Response? response; // Define response variable outside try block

    try {
      response = await http.post(
        // Assign response inside try block
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // If authentication is successful, extract token from response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        String token = responseData['token'];

        // Use provider to set the token
        Provider.of<TokenModel>(context, listen: false).setToken(token);
        log("status code: ${response.statusCode}");
        log("Token: $token");
        log("$responseData");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RegisteredHomeScreen()),
        );

        // Return success message
        return "${responseData["success"]}";
      } else {
        // Authentication failed, return error message
        return "Authentication failed";
      }
    } catch (error) {
      // Handle any errors that occur during the API call
      log('Error occurred: $error');

      // Check if response is null (indicating error before HTTP response)
      if (response == null) {
        log('Error: No HTTP response');
      } else {
        log('Response status code: ${response.statusCode}'); // Access response variable safely
        log('Response body: ${response.body}'); // Access response variable safely
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error occurred while authenticating'),
        ),
      );
      return 'Error occurred while authenticating';
    }
  }
}
