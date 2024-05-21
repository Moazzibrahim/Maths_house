import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/all_courses_model.dart';
import 'package:http/http.dart' as http;

class CategoriesServices with ChangeNotifier {
  List<Categouries> allCategouries = [];
  Future getAllCategoriesData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/customer_category'),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        CategouriesList categouriesList =
            CategouriesList.fromJson(responseData);
        List<Categouries> cl = categouriesList.categouriesList
            .map((e) => Categouries.fromJson(e))
            .toList();
            allCategouries = cl;
            notifyListeners();
      } else {
        log('error with Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('error: $e');
    }
  }
}
