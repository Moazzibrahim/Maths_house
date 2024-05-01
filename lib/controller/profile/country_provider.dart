// Function to fetch data from API
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/sign_up/country_model.dart';
import 'package:http/http.dart' as http;

// Function to fetch data from APIimport 'dart:developer'; // Importing dart:developer

class SignupProvider with ChangeNotifier {
  List<Country> allcountries = [];
  String?
      selectedCountry; // Assuming you have this variable declared somewhere.

  Future<void> fetchCountry() async {
    try {
      final response = await http
          .get(Uri.parse('https://login.mathshouse.net/api/stu_sign_up_page'));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        CountryList countryList = CountryList.fromJson(responseData);
        List<Country> cl =
            countryList.countryList.map((e) => Country.fromJson(e)).toList();
        allcountries = cl;
        print(allcountries);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('error: $e');
    }
  }

  List<City> allcities = [];

  Future<void> fetchCity() async {
    try {
      final response = await http
          .get(Uri.parse('https://login.mathshouse.net/api/stu_sign_up_page'));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        CityList cityList = CityList.fromJson(responseData);
        List<City> ci = cityList.cityList.map((e) => City.fromJson(e)).toList();
        allcities = ci;
        notifyListeners();
        print(allcities);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('error: $e');
    }
  }
}
