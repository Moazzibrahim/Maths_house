import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/Model/profile_name.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfileProvider with ChangeNotifier {
  List<User> profiledetails = [];

  Future<void> getCoursesData(BuildContext context) async {
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
        // Assuming responseData contains a list of user data under the key 'users'
        final List<dynamic> userDataList = responseData['users'];
        profiledetails.clear(); // Clear existing data before adding new data

        // Parse each user data and add it to profiledetails list
        for (var userData in userDataList) {
          profiledetails.add(User.fromJson(userData));
        }

        notifyListeners();
      } else {
        log('Failed to fetch data');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
