// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';

class GetExamProvider with ChangeNotifier {
  static const String baseUrl =
      'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_exam_grade';
  static const int maxRetries = 5;
  static const int initialDelay = 1000; // Initial delay in milliseconds

  Future<Map<String, dynamic>?>? fetchExamResults(
      Map<String, dynamic> postData, BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    final Uri uri = _buildUri(postData);
    return _retryFetch(uri, token!);
  }

  Uri _buildUri(Map<String, dynamic> postData) {
    final queryParams = StringBuffer();
    postData.forEach((key, value) {
      queryParams.write('$key=$value&');
    });
    return Uri.parse('$baseUrl?$queryParams');
  }

  Future<Map<String, dynamic>?> _retryFetch(Uri uri, String token) async {
    int retryCount = 0;

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
          return _handleSuccess(response);
        } else if (response.statusCode == 429) {
          await _handleRateLimit(retryCount);
          retryCount++;
        } else {
          _handleFailure(response);
        }
      } catch (e) {
        if (retryCount < maxRetries) {
          await _handleRetry(retryCount, e);
          retryCount++;
        } else {
          throw Exception('Max retries reached. Failed to fetch exam results');
        }
      }
    }

    return null;
  }

  Future<void> _handleRateLimit(int retryCount) async {
    print('Rate limit exceeded. Retrying...');
    await Future.delayed(
        Duration(milliseconds: initialDelay * (retryCount + 1)));
  }

  void _handleFailure(http.Response response) {
    print('Failed to retrieve exam results: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to fetch exam results');
  }

  Future<void> _handleRetry(int retryCount, dynamic error) async {
    print('Error retrieving exam results: $error');
    print('Retrying...');
    await Future.delayed(
        Duration(milliseconds: initialDelay * (retryCount + 1)));
  }

  Map<String, dynamic> _handleSuccess(http.Response response) {
    final Map<String, dynamic> data = json.decode(response.body);
    print('Exam results retrieved successfully:');
    print(data);
    return data;
  }
}
