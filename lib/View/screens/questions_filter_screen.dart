import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/questions_screen.dart';
import 'package:flutter_application_1/View/widgets/custom_dropdownbutton.dart';
import 'package:flutter_application_1/constants/colors.dart';

class QuestionFilterScreen extends StatefulWidget {
  const QuestionFilterScreen({super.key});

  @override
  State<QuestionFilterScreen> createState() => _QuestionFilterScreenState();
}

class _QuestionFilterScreenState extends State<QuestionFilterScreen> {
  final List<String> months = [
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
  String selectedCategory = 'Select Category';
  String selectedCourse = 'Select Course';
  String selectedYear = 'Select Year';
  String selectedMonth = 'Select Month';
  String selectedExamCode = 'Select Exam Code';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: gridHomeColor, borderRadius: BorderRadius.circular(12)),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.redAccent[700],
              )),
        ),
        title: const Text(
          'Questions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              CustomDropdownButton(
                value: selectedCategory,
                items: const ['Select Category', 'cat a', 'cat b'],
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomDropdownButton(
                value: selectedCourse,
                items: const ['Select Course', 'cat a', 'cat b'],
                onChanged: (newValue) {
                  setState(() {
                    selectedCourse = newValue!;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomDropdownButton(
                value: selectedMonth,
                items: ['Select Month', ...months],
                onChanged: (newValue) {
                  setState(() {
                    selectedMonth = newValue!;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomDropdownButton(
                value: selectedYear,
                items: const ['Select Year', '2020', '2021','2022','2023','2024'],
                onChanged: (newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomDropdownButton(
                value: selectedExamCode,
                items: const ['Select Exam Code', 'cat a', 'cat b'],
                onChanged: (newValue) {
                  setState(() {
                    selectedExamCode = newValue!;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx)=>const QuestionsScreen())
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent[700],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 130
                  )
                ),
                child: const Text('Search',style: TextStyle(color: Colors.white,fontSize: 20),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
