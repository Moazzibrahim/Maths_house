// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class DiagnosticFilterScreen extends StatefulWidget {
  const DiagnosticFilterScreen({Key? key}) : super(key: key);

  @override
  State<DiagnosticFilterScreen> createState() => _DiagnosticFilterScreenState();
}

class _DiagnosticFilterScreenState extends State<DiagnosticFilterScreen> {
  String? _selectedCategory;
  String? _selectedCourse;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildDropdownContainer(
      {required String hint,
      required List<String> items,
      required String? value,
      required Function(String?) onChanged}) {
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
          DropdownButtonFormField<String>(
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            iconEnabledColor: faceBookColor,
            value: value,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: faceBookColor,
          ),
        ),
        title: const Text("Diagnostic Exam"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDropdownContainer(
              hint: "Select category",
              items: ['Category 1', 'Category 2', 'Category 3'],
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 20), // Adjust as needed
            _buildDropdownContainer(
              hint: "Select course",
              items: ['Course 1', 'Course 2', 'Course 3'],
              value: _selectedCourse,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCourse = newValue;
                });
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: faceBookColor,
                shape: const LinearBorder(),
              ),
              child: const Text(
                "search",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
