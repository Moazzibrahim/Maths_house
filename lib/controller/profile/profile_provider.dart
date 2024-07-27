import 'dart:async';
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
  DateTime? _lastFetchTime;
  final Duration _cacheDuration = Duration(minutes: 5); // Cache duration

  Future<void> getprofileData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    if (_userData != null && _lastFetchTime != null && 
        DateTime.now().difference(_lastFetchTime!) < _cacheDuration) {
      // Use cached data
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_profile_data'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        User? user = User.fromJson(responseData);
        _userData = user;
        _lastFetchTime = DateTime.now();
        notifyListeners();
      } else {
        log('Failed to fetch data proff: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
