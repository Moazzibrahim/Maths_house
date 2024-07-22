// ignore_for_file: avoid_print, deprecated_member_use, use_build_context_synchronously, unused_field

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/Diagnostic_exams/training.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/diagnostic/diagnostic_filteration_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiagnosticFilterScreen extends StatefulWidget {
  const DiagnosticFilterScreen({Key? key}) : super(key: key);

  @override
  State<DiagnosticFilterScreen> createState() => _DiagnosticFilterScreenState();
}

class _DiagnosticFilterScreenState extends State<DiagnosticFilterScreen> {
  String? _selectedCategory;
  String? _selectedCourse;
  int? _selectedCourseId;

  @override
  void initState() {
    super.initState();
    Provider.of<DiagnosticFilterationProvider>(context, listen: false)
        .fetchdiagdata(context);
  }

  Future<void> sendFiltersDiagnosticToServers() async {
    if (_selectedCategory == null || _selectedCourse == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must fill both category and course!'),
        ),
      );
      return;
    }

    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    final provider =
        Provider.of<DiagnosticFilterationProvider>(context, listen: false);
    final selectedCourse = _selectedCourse;

    final selectedCourseId = provider.courseIds.firstWhere(
      (courseId) => selectedCourse == provider.courseData[courseId - 15],
      orElse: () => -1,
    );

    if (selectedCourseId == -1) {
      log('Selected course not found!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selected course not found!'),
        ),
      );
      return;
    }

    setState(() {
      _selectedCourseId = selectedCourseId;
    });

    log("selected course id: $selectedCourseId");

    final url = Uri.parse(
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_dia_exam/$selectedCourseId');

    final Map<String, dynamic> requestBody = {
      'category': _selectedCategory,
      'course': selectedCourseId.toString(),
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        log('Filters sent successfully!');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiagnosticExamScreen(
              selectedCourseId: selectedCourseId,
            ),
          ),
        );
      } else {
        log('Failed to send filters. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Failed to send filters. please check your connection'),
          ),
        );
      }
    } catch (error) {
      log('Error sending filters: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending filters: $error'),
        ),
      );
    }
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

  String truncateText(String text, {int length = 40}) {
    return text.length > length ? '${text.substring(0, length)}...' : text;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false); // Prevent back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: faceBookColor,
            ),
          ),
          title: const Text("Diagnostic Exam filter"),
        ),
        body: Consumer<DiagnosticFilterationProvider>(
          builder: (context, provider, _) {
            List<String> uniqueCategories =
                provider.categoryData.toSet().toList();
            List<String> uniqueCourses = provider.courseData.toSet().toList();
            return provider.courseData.isEmpty || provider.categoryData.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildDropdownContainer(
                          hint: "Select Category",
                          child: DropdownButtonFormField<String>(
                            iconEnabledColor: faceBookColor,
                            value: _selectedCategory,
                            items: uniqueCategories
                                .map(
                                  (category) => DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(
                                      truncateText(category),
                                      overflow: TextOverflow
                                          .ellipsis, // Handle overflow
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDropdownContainer(
                          hint: "Select Course",
                          child: DropdownButtonFormField<String>(
                            iconEnabledColor: faceBookColor,
                            value: _selectedCourse,
                            items: uniqueCourses
                                .map(
                                  (course) => DropdownMenuItem<String>(
                                    value: course,
                                    child: Text(
                                      truncateText(course),
                                      overflow: TextOverflow
                                          .ellipsis, // Handle overflow
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCourse = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            sendFiltersDiagnosticToServers();
                            print('Category: $_selectedCategory');
                            print('Course: $_selectedCourse');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: faceBookColor,
                            shape: const LinearBorder(),
                          ),
                          child: const Text(
                            "Search",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
