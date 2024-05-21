// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/Model/package_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PackageProvider with ChangeNotifier {
  List<ExamPackage> allexamspackage = [];

  Future<void> fetchexam(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
          Uri.parse(
              'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_packages'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        ExamPackageList examList = ExamPackageList.fromJson(responseData);
        List<ExamPackage> ex = examList.exampackageList
            .map((e) => ExamPackage.fromJson(e))
            .toList();
        allexamspackage = ex;
        print(allexamspackage);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('error: $e');
    }
  }

  List<QuestionPackage> allquestionpackage = [];

  Future<void> fetchQuestion(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
          Uri.parse(
              'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_packages'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        QuestionPackageList questionList =
            QuestionPackageList.fromJson(responseData);
        List<QuestionPackage> qu = questionList.questionpackageList
            .map((e) => QuestionPackage.fromJson(e))
            .toList();
        allquestionpackage = qu;
        print(allquestionpackage);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('error: $e');
    }
  }

  List<LivePackage> alllivepackage = [];

  Future<void> fetchlive(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
          Uri.parse(
              'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_packages'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        LivePackageList liveList = LivePackageList.fromJson(responseData);
        List<LivePackage> li = liveList.livepackageList
            .map((e) => LivePackage.fromJson(e))
            .toList();
        alllivepackage = li;
        print(alllivepackage);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log('error: $e');
    }
  }
}
