import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/Model/profile_name.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfileProvider with ChangeNotifier {
  User? _userData;

  User? get userData => _userData;
  Future<void> getprofileData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_profile_data'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        User? user = User.fromJson(responseData); // Use User? instead of User
        _userData = user;
        notifyListeners();
      } else {
        log('Failed to fetch data proffff');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
