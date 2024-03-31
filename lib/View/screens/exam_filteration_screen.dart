// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/start_exam_screen.dart';

class ExamFilterScreen extends StatefulWidget {
  const ExamFilterScreen({Key? key}) : super(key: key);

  @override
  _ExamFilterScreenState createState() => _ExamFilterScreenState();
}

class _ExamFilterScreenState extends State<ExamFilterScreen> {
  String _selectedCategory = 'Category 1';
  String _selectedCourse = 'Course 1';
  String _selectedYear = '2022';
  String _selectedMonth = 'January';
  String _selectedExamCode = 'Code 1';

  final List<String> _categories = ['Category 1', 'Category 2', 'Category 3'];
  final List<String> _courses = ['Course 1', 'Course 2', 'Course 3'];
  final List<String> _years = ['2022', '2023', '2024'];
  final List<String> _months = ['January', 'February', 'March'];
  final List<String> _examCodes = ['Code 1', 'Code 2', 'Code 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedCourse,
              items: _courses
                  .map((course) => DropdownMenuItem(
                        value: course,
                        child: Text(course),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCourse = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedYear,
              items: _years
                  .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedYear = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedMonth,
              items: _months
                  .map((month) => DropdownMenuItem(
                        value: month,
                        child: Text(month),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMonth = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedExamCode,
              items: _examCodes
                  .map((examCode) => DropdownMenuItem(
                        value: examCode,
                        child: Text(examCode),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedExamCode = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform search based on selected filters
                // For demonstration purposes, let's just print the selected filter values
                print('Category: $_selectedCategory');
                print('Course: $_selectedCourse');
                print('Year: $_selectedYear');
                print('Month: $_selectedMonth');
                print('Exam Code: $_selectedExamCode');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExamScreenstart()),
                );
                // Here you can implement your logic to fetch exams based on the selected filters
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
