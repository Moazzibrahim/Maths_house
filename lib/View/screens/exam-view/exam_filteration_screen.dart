// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/exam-view/start_exam_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/exam/exam_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ExamFilterScreen extends StatefulWidget {
  const ExamFilterScreen({super.key});

  @override
  _ExamFilterScreenState createState() => _ExamFilterScreenState();
}

class _ExamFilterScreenState extends State<ExamFilterScreen> {
  String? _selectedCategory;
  String? _selectedCourse;
  String? _selectedYear;
  String? _selectedMonth;
  String? _selectedExamCode;
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  late List<String> _years;

  @override
  void initState() {
    super.initState();
    _years = generateYearsList(1990, DateTime.now().year);
    Provider.of<ExamProvider>(context, listen: false).fetchData(context);
  }

  List<String> generateYearsList(int startYear, int endYear) {
    List<String> years = [];
    for (int year = startYear; year <= endYear; year++) {
      years.add(year.toString());
    }
    return years;
  }

  Future<void> _sendFiltersToServer() async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    // Construct the request body with selected filter values
    final Map<String, dynamic> requestBody = {
      'category': _selectedCategory,
      'course': _selectedCourse,
      'year': _selectedYear,
      'month': _selectedMonth,
      'examCode': _selectedExamCode,
    };

    final url = Uri.parse(
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_filter_exam_process');

    try {
      // Send a POST request to the server
      final response = await http.post(
        url,
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          // Add any additional headers if required
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Request was successful, handle the response here
        print('Filters sent successfully!');
        print('Response body: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ExamScreenstart(),
          ),
        );
      } else {
        // Request failed, handle error here
        print('Failed to send filters. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that occur during the HTTP request
      print('Error sending filters: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Filter'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: faceBookColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<ExamProvider>(
        builder: (context, examProvider, _) {
          // Remove duplicates from categoryData, courseData, and examCodeData
          List<String> uniqueCategories =
              examProvider.categoryData.toSet().toList();
          List<String> uniqueCourses = examProvider.courseData.toSet().toList();
          List<String> uniqueExamCodes =
              examProvider.examCodeData.toSet().toList();

          return examProvider.courseData.isEmpty ||
                  examProvider.categoryData.isEmpty ||
                  examProvider.examCodeData.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDropdownContainer(
                        hint: "Select Category",
                        child: DropdownButtonFormField<String>(
                          iconEnabledColor: faceBookColor,
                          value: _selectedCategory,
                          items: [
                            ...uniqueCategories.map(
                              (category) => DropdownMenuItem<String>(
                                value: category,
                                child: Row(
                                  children: [
                                    Text(category),
                                  ],
                                ),
                              ),
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildDropdownContainer(
                        hint: "Select Course",
                        child: DropdownButtonFormField<String>(
                          iconEnabledColor: faceBookColor,
                          value: _selectedCourse,
                          items: [
                            ...uniqueCourses.map(
                              (course) => DropdownMenuItem<String>(
                                value: course,
                                child: Row(
                                  children: [
                                    Text(course), // Customize arrow color here
                                  ],
                                ),
                              ),
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedCourse = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildDropdownContainer(
                        hint: "Select Year",
                        child: DropdownButtonFormField<String>(
                          iconEnabledColor: faceBookColor,
                          value: _selectedYear,
                          items: [
                            ..._years.map(
                              (year) => DropdownMenuItem<String>(
                                value: year,
                                child: Row(
                                  children: [
                                    Text(year),
                                    // Customize arrow color here
                                  ],
                                ),
                              ),
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedYear = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildDropdownContainer(
                        hint: "Select Month",
                        child: DropdownButtonFormField<String>(
                          iconEnabledColor: faceBookColor,
                          value: _selectedMonth,
                          items: [
                            ..._months.map(
                              (month) => DropdownMenuItem<String>(
                                value: month,
                                child: Row(
                                  children: [
                                    Text(month),
                                    // Customize arrow color here
                                  ],
                                ),
                              ),
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedMonth = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildDropdownContainer(
                        hint: "Select Exam Code",
                        child: DropdownButtonFormField<String>(
                          iconEnabledColor: faceBookColor,
                          value: _selectedExamCode,
                          items: [
                            ...uniqueExamCodes.map(
                              (code) => DropdownMenuItem<String>(
                                value: code,
                                child: Row(
                                  children: [
                                    Text(code),
                                    // Customize arrow color here
                                  ],
                                ),
                              ),
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedExamCode = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _sendFiltersToServer();
                          // For demonstration purposes, let's just print the selected filter values
                          print('Category: $_selectedCategory');
                          print('Course: $_selectedCourse');
                          print('Year: $_selectedYear');
                          print('Month: $_selectedMonth');
                          print('Exam Code: $_selectedExamCode');
                          // Here you can implement your logic to fetch exams based on the selected filters
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: faceBookColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 120,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _buildDropdownContainer(
      {required String hint, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 5),
          child,
        ],
      ),
    );
  }
}
