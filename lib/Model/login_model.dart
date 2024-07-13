// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';

class TokenModel with ChangeNotifier {
  String? _token;

  String? get token => _token;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }
}

class LoginModel with ChangeNotifier {
  late int _id;
  int get id => _id;

  void setId(int id) {
    _id = id;
    notifyListeners();
  }

  Future<String> loginUser(
      BuildContext context, String email, String password) async {
    String apiUrl = 'https://login.mathshouse.net/api/login';
    http.Response? response;

    try {
      response = await http.post(
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
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        String token = responseData['token'];
        int id = responseData['user']['id'];

        Provider.of<TokenModel>(context, listen: false).setToken(token);
        Provider.of<LoginModel>(context, listen: false).setId(id);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('token', token); // Save the token

        log("status code: ${response.statusCode}");
        log("Token: $token");
        log("id: $id");
        log("$responseData");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const TabsScreen(
                  isLoggedIn: false)), // Redirect with isLoggedIn: true
        );

        return "${responseData["success"]}";
      } else {
        return "Authentication failed";
      }
    } catch (error) {
      log('Error occurred: $error');

      if (response == null) {
        log('Error: No HTTP response');
      } else {
        log('Response status code: ${response.statusCode}');
        log('Response body: ${response.body}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your email or password is incorrect'),
        ),
      );
      return 'Error occurred while authenticating';
    }
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.remove('token'); // Remove the token
    notifyListeners();
  }
}
