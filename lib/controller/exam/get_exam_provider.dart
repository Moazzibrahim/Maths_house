// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';

class GetExamProvider with ChangeNotifier {
  Future<Map<String, dynamic>?>? fetchExamResults(
      Map<String, dynamic> postData, BuildContext context) async {
    const baseUrl =
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam_grade';
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token; // Replace with your auth token

    // Construct the query parameters
    String queryParams = '';
    postData.forEach((key, value) {
      queryParams += '$key=$value&';
    });
    final Uri uri = Uri.parse('$baseUrl?$queryParams');

    int retryCount = 0;
    const int maxRetries = 5;
    const int initialDelay = 1000; // Initial delay in milliseconds

    while (retryCount < maxRetries) {
      try {
        final response = await http.get(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          // Decode the response body
          final Map<String, dynamic> data = json.decode(response.body);

          // Process the data as needed
          print('Exam results retrieved successfully:');
          print(data);
          return data;
        } else if (response.statusCode == 429) {
          // Handle rate limiting
          print('Rate limit exceeded. Retrying...');
          await Future.delayed(Duration(milliseconds: initialDelay * (retryCount + 1)));
          retryCount++;
        } else {
          print('Failed to retrieve exam results: ${response.statusCode}');
          // Print response body for more details
          print('Response body: ${response.body}');
          throw Exception('Failed to fetch exam results');
        }
      } catch (e) {
        print('Error retrieving exam results: $e');
        if (retryCount < maxRetries) {
          print('Retrying...');
          await Future.delayed(Duration(milliseconds: initialDelay * (retryCount + 1)));
          retryCount++;
        } else {
          throw Exception('Max retries reached. Failed to fetch exam results');
        }
      }
    }

    return null;
  }
}
