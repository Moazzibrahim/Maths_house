// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GetCourseProvider with ChangeNotifier {
  Future<Map<String, dynamic>> fetchDataFromApi(
      Map<String, dynamic> requestData, BuildContext context) async {
    // Build the query parameters
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    String queryParams = '';
    requestData.forEach((key, value) {
      if (queryParams.isNotEmpty) {
        queryParams += '&';
      }
      queryParams += '$key=$value';
    });

    // Make the HTTP GET request
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_dia_grade?$queryParams'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response JSON
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        return responseData;
      } else {
        // Handle the error response
        print('Failed to fetch data: ${response.statusCode}');
        return {}; // Return an empty map in case of error
      }
    } catch (e) {
      print('Error fetching data: $e');
      return {}; // Return an empty map in case of exception
    }
  }
}
