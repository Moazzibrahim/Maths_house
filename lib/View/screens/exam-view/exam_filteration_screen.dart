// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api, deprecated_member_use
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
    final examProvider = Provider.of<ExamProvider>(context, listen: false);

    // Find the selected category ID
    int? selectedCategoryId;
    if (_selectedCategory != null) {
      final index = examProvider.categoryNames.indexOf(_selectedCategory!);
      if (index != -1) {
        selectedCategoryId = examProvider.categoryIds[index];
      }
    }

    // Find the selected course ID
    int? selectedCourseId;
    if (_selectedCourse != null) {
      final index = examProvider.courseNames.indexOf(_selectedCourse!);
      if (index != -1) {
        selectedCourseId = examProvider.courseIds[index];
      }
    }

    // Find the selected exam code ID
    int? selectedExamCodeId;
    if (_selectedExamCode != null) {
      final index = examProvider.examCodes.indexOf(_selectedExamCode!);
      if (index != -1) {
        selectedExamCodeId = examProvider.examCodeIds[index];
      }
    }

    // Convert the selected month to its numeric representation
    int? selectedMonthNumber;
    if (_selectedMonth != null) {
      selectedMonthNumber = _months.indexOf(_selectedMonth!) + 1;
    }

    // Construct the request body with selected filter values
    final Map<String, dynamic> requestBody = {
      'category_id': selectedCategoryId,
      'course_id': selectedCourseId,
      'year': _selectedYear,
      'month': selectedMonthNumber,
      'code_id': selectedExamCodeId,
    };

    final url = Uri.parse(
        // ignore: unnecessary_brace_in_string_interps
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_filter_exam_process');

    try {
      // Send a POST request to the server
      final response = await http.post(
        url,
        body: jsonEncode(requestBody),
        //  body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Request was successful, handle the response here
        print('Filters sent successfully!');
        print('Response body: ${response.body}');
        print("Exam code ID: $selectedExamCodeId");
        print("Selected category: $selectedCategoryId");
        print("Selected month: $selectedMonthNumber");
        print("Selected course: $selectedCourseId");
        print("selected year: $_selectedYear");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExamScreenstart(
              categoryid: selectedCategoryId,
              courseid: selectedCourseId,
              months: selectedMonthNumber,
              examcodeid: selectedExamCodeId,
              years: _selectedYear,
            ),
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
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false); // Prevent back navigation
      },
      child: Scaffold(
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
            return examProvider.courseNames.isEmpty ||
                    examProvider.categoryNames.isEmpty ||
                    examProvider.examCodes.isEmpty
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
                              ...examProvider.categoryNames.map(
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
                              ...examProvider.courseNames.map(
                                (course) => DropdownMenuItem<String>(
                                  value: course,
                                  child: Row(
                                    children: [
                                      Text(course),
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
                              ...examProvider.examCodes.map(
                                (code) => DropdownMenuItem<String>(
                                  value: code,
                                  child: Row(
                                    children: [
                                      Text(code),
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
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
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
