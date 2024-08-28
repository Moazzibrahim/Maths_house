// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/Model/package_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PackageProvider extends ChangeNotifier {
  List<LivePackage> _livePackages = [];
  List<Course> _allCourses = [];
  List<LivePackage> _filteredLivePackages = [];
  List<QuestionPackage> _questionPackages = [];
  List<QuestionPackage> _filteredPackages = [];
  List<Exam> _exams = [];
  List<Exam> _filteredExams = [];
  List<Exam> get filteredExams => _filteredExams;

  List<LivePackage> get filteredLivePackage => _filteredLivePackages;
  List<Course> get allCourses => _allCourses;
  List<QuestionPackage> get filteredPackages => _filteredPackages;

  Future<void> fetchLive(BuildContext context) async {
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
        },
      );
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        _livePackages = (data['Live'] as List)
            .map((item) => LivePackage.fromJson(item))
            .toList();
        _filteredLivePackages = List.from(_livePackages);
        notifyListeners();
      } else {
        print('Failed to load live packages');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchCourses(BuildContext context) async {
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
        },
      );
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        _allCourses = (data['courses'] as List)
            .map((item) => Course.fromJson(item))
            .toList();
        notifyListeners();
      } else {
        print('Failed to load courses');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchQuestionPackages(BuildContext context) async {
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
        },
      );

      final data = json.decode(response.body);
      print('API Response: $data'); // Log the full response

      if (response.statusCode == 200) {
        if (data['Questions'] != null) {
          _questionPackages = (data['Questions'] as List)
              .map((item) => QuestionPackage.fromJson(item))
              .toList();
          _filteredPackages = List.from(_questionPackages);
          notifyListeners();
        } else {
          print('No Questions data available');
        }
      } else {
        print(
            'Failed to load question packages, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchExams(BuildContext context) async {
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
        },
      );

      final data = json.decode(response.body);
      print('API Response: $data'); // Log the full response

      if (response.statusCode == 200) {
        if (data['Exams'] != null) {
          _exams = (data['Exams'] as List)
              .map((item) => Exam.fromJson(item))
              .toList();
          _filteredExams = List.from(_exams);
          notifyListeners();
        } else {
          print('No Exams data available');
        }
      } else {
        print('Failed to load exams, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Function to filter exams by course ID
  void filterExamsByCourseId(int courseId) {
    _filteredExams = _exams.where((exam) => exam.courseId == courseId).toList();
    notifyListeners();
  }

  void filterLivePackagesByCourseId(int courseId) {
    _filteredLivePackages =
        _livePackages.where((package) => package.courseId == courseId).toList();
    notifyListeners();
  }

  void filterPackagesByCourseId(int courseId) {
    _filteredPackages = _questionPackages
        .where((package) => package.courseId == courseId)
        .toList(); // Adjust filtering logic to match the courseId
    notifyListeners();
  }
}
