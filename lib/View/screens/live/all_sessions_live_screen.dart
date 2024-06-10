import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/diagnostic_exams/diagnostic_filteration.dart';
import 'package:flutter_application_1/Model/live/live_filteration_model.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/live_filter_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AllSessionsLiveScreen extends StatefulWidget {
  const AllSessionsLiveScreen({super.key});

  @override
  State<AllSessionsLiveScreen> createState() => _AllSessionsLiveScreenState();
}

class _AllSessionsLiveScreenState extends State<AllSessionsLiveScreen> {
  DiagnosticCategory? _selectedCategory;
  DiagnosticCourse? _selectedCourse;
  String? _selectedEndDate;

  void _onSearchPressed() {
    if (_selectedCategory != null && _selectedCourse != null && _selectedEndDate != null) {
      Provider.of<LiveFilterProvider>(context, listen: false).postCategoryData(
        _selectedCategory!.id,
        _selectedCourse!.id,
        _selectedEndDate!,
        context,
      );
    } else {
      // Show some error message or feedback to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select all fields before searching')),
      );
    }
  }

  void _onCategoryChanged(DiagnosticCategory? category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _onCourseChanged(DiagnosticCourse? course) {
    setState(() {
      _selectedCourse = course;
    });
  }

  void _onEndDateChanged(String? endDate) {
    setState(() {
      _selectedEndDate = endDate;
    });
  }

  @override
  void initState() {
    Provider.of<LiveFilterationProvider>(context, listen: false)
        .fetchDiagData(context)
        .catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'All Session'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _DropdownsAndButton(
          onPressed: _onSearchPressed,
          onCategoryChanged: _onCategoryChanged,
          onCourseChanged: _onCourseChanged,
          onStartDateChanged: (_) {}, // Not used, but required by the widget
          onEndDateChanged: _onEndDateChanged,
        ),
      ),
    );
  }
}

class _DropdownsAndButton extends StatefulWidget {
  final VoidCallback onPressed;
  final ValueChanged<DiagnosticCategory?> onCategoryChanged;
  final ValueChanged<DiagnosticCourse?> onCourseChanged;
  final ValueChanged<String?> onStartDateChanged; // Not used, but required by the widget
  final ValueChanged<String?> onEndDateChanged;

  const _DropdownsAndButton({
    Key? key,
    required this.onPressed,
    required this.onCategoryChanged,
    required this.onCourseChanged,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Diagnostic Category'),
          Consumer<LiveFilterationProvider>(
            builder: (context, liveFilterationProvider, _) {
              return DropdownButton<DiagnosticCategory>(
                value: _selectedCategory,
                hint: const Text('Select Category'),
                items: liveFilterationProvider.categoryData.map((category) {
                  return DropdownMenuItem<DiagnosticCategory>(
                    value: category,
                    child: Text(category.categoryName),
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
          const SizedBox(height: 10),
          const Text('Diagnostic Course'),
          Consumer<LiveFilterationProvider>(
            builder: (context, liveFilterationProvider, _) {
              return DropdownButton<DiagnosticCourse>(
                value: _selectedCourse,
                hint: const Text('Select Course'),
                items: liveFilterationProvider.courseData.map((course) {
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
          const SizedBox(height: 10),
          const Text('End Date'),
          DropdownButton<String>(
            value: _selectedEndDate,
            hint: const Text('Select End Date'),
            items: _dates.map((date) {
              return DropdownMenuItem<String>(
                value: date,
                child: Text(date),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedEndDate = value;
                widget.onEndDateChanged(value);
              });
            },
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent[700]!),
              ),
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
