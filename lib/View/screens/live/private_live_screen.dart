// ignore_for_file: unused_element, unused_field, use_build_context_synchronously, avoid_print, deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/diagnostic_exams/diagnostic_filteration.dart';
import 'package:flutter_application_1/Model/live/live_filteration_model.dart';
import 'package:flutter_application_1/Model/live/private_live_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/live/get_private_data_screen.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PrivateLiveScreen extends StatelessWidget {
  const PrivateLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Private Live'),
      body: _DropdownsAndButton(
        onCategoryChanged: (value) {},
        onCourseChanged: (value) {},
        onEndDateChanged: (value) {},
        onStartDateChanged: (value) {},
      ),
    );
  }
}

class _DropdownsAndButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final ValueChanged<DiagnosticCategory?> onCategoryChanged;
  final ValueChanged<DiagnosticCourse?> onCourseChanged;
  final ValueChanged<String?> onStartDateChanged;
  final ValueChanged<String?> onEndDateChanged;

  const _DropdownsAndButton({
    super.key,
    this.onPressed,
    required this.onCategoryChanged,
    required this.onCourseChanged,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  @override
  __DropdownsAndButtonState createState() => __DropdownsAndButtonState();
}

class __DropdownsAndButtonState extends State<_DropdownsAndButton> {
  DiagnosticCategory? _selectedCategory;
  DiagnosticCourse? _selectedCourse;
  List<String> _dates = [];
  String? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _initializeDates();
    Provider.of<LiveFilterationProvider>(context, listen: false)
        .fetchDiagData(context);
  }

  void _initializeDates() {
    final today = DateTime.now();
    final oneYearFromNow = today.add(const Duration(days: 60));
    final dateList = <DateTime>[];

    for (var date = today;
        date.isBefore(oneYearFromNow);
        date = date.add(const Duration(days: 1))) {
      dateList.add(date);
    }

    setState(() {
      _dates = dateList
          .map((date) => DateFormat('yyyy-MM-dd').format(date))
          .toList();
    });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedEndDate = DateFormat('yyyy-MM-dd').format(picked);
        widget.onEndDateChanged(_selectedEndDate);
      });
    }
  }

  String truncateText(String text, {int length = 30}) {
    return text.length > length ? '${text.substring(0, length)}...' : text;
  }

  Future<void> _postSessionData() async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    final url = Uri.parse(
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/session_private_live');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'category_id': _selectedCategory?.id,
      'course_id': _selectedCourse?.id,
      'end_date': _selectedEndDate,
    });
    log("body:$body");

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // Handle successful response
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        print("response body:$responseData");
        final apiResponse = ApiResponse.fromJson(responseData);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SessionDataScreen(
              sessionData: apiResponse.liveRequest[0],
            ),
          ),
        );
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to post session data!')),
        );
        print("status code:${response.statusCode}");
      }
    } catch (e) {
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  bool _isAllFieldsSelected() {
    return _selectedCategory != null &&
        _selectedCourse != null &&
        _selectedEndDate != null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Diagnostic Category',
              ),
              const SizedBox(height: 10),
              Consumer<LiveFilterationProvider>(
                builder: (context, liveFilterationProvider, _) {
                  final categories = liveFilterationProvider.categoryData;
                  if (categories.isEmpty ||
                      !categories.contains(_selectedCategory)) {
                    _selectedCategory = null;
                  }
                  return DropdownButtonFormField<DiagnosticCategory>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: _selectedCategory,
                    hint: const Text('Select Category'),
                    items: categories.map((category) {
                      return DropdownMenuItem<DiagnosticCategory>(
                        value: category,
                        child: Text(truncateText(category.categoryName)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                        widget.onCategoryChanged(value);
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Diagnostic Course',
              ),
              const SizedBox(height: 10),
              Consumer<LiveFilterationProvider>(
                builder: (context, liveFilterationProvider, _) {
                  final courses = liveFilterationProvider.courseData;
                  if (courses.isEmpty || !courses.contains(_selectedCourse)) {
                    _selectedCourse = null;
                  }
                  return DropdownButtonFormField<DiagnosticCourse>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: _selectedCourse,
                    hint: const Text('Select Course'),
                    items: courses.map((course) {
                      return DropdownMenuItem<DiagnosticCourse>(
                        value: course,
                        child: Text(course.courseName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCourse = value;
                        widget.onCourseChanged(value);
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Select End Date',
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectEndDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Select End Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(text: _selectedEndDate),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _isAllFieldsSelected()
                        ? _postSessionData()
                        : ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('All the fields are required')),
                          );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent[700],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
