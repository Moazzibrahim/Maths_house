// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/tabs_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create a class to hold the token
class TokenModel with ChangeNotifier {
  String? _token;

  String? get token => _token;

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
  late int _id; // Define the _id variable
  int get id => _id; // Define a getter for id

  // Constructor and other methods...

  // Method to set id
  void setId(int id) {
    _id = id;
    notifyListeners();
  }

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
        int id = responseData['user']['id'];

        // Use provider to set the token
        Provider.of<TokenModel>(context, listen: false).setToken(token);
        Provider.of<LoginModel>(context, listen: false).setId(id);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        log("status code: ${response.statusCode}");
        log("Token: $token");
        log("id: $id");
        log("$responseData");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const TabsScreen(
                    isLoggedIn: false,
                  )),
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
          content: Text('Your email or password is incorrect'),
        ),
      );
      return 'Error occurred while authenticating';
    }
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    notifyListeners();
  }
}
