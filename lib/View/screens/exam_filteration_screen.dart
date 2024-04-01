import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/start_exam_screen.dart';
import 'package:flutter_application_1/controller/exam_provider.dart';
import 'package:provider/provider.dart';

class ExamFilterScreen extends StatefulWidget {
  const ExamFilterScreen({Key? key}) : super(key: key);

  @override
  _ExamFilterScreenState createState() => _ExamFilterScreenState();
}

class _ExamFilterScreenState extends State<ExamFilterScreen> {
  String? _selectedCategory;
  String? _selectedCourse;
  String _selectedYear = '2024';
  String _selectedMonth = 'January';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Filter'),
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
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        items: uniqueCategories
                            .map((category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedCourse,
                        items: uniqueCourses
                            .map((course) => DropdownMenuItem<String>(
                                  value: course,
                                  child: Text(course),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCourse = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedYear,
                        items: _years
                            .map((year) => DropdownMenuItem<String>(
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
                            .map((month) => DropdownMenuItem<String>(
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
                        items: uniqueExamCodes
                            .map((code) => DropdownMenuItem<String>(
                                  value: code,
                                  child: Text(code),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedExamCode = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ExamScreenstart(),
                            ),
                          );
                          // For demonstration purposes, let's just print the selected filter values
                          print('Category: $_selectedCategory');
                          print('Course: $_selectedCourse');
                          print('Year: $_selectedYear');
                          print('Month: $_selectedMonth');
                          print('Exam Code: $_selectedExamCode');
                          // Here you can implement your logic to fetch exams based on the selected filters
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
