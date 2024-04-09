import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/questions_screen.dart';
import 'package:flutter_application_1/constants/colors.dart';

class QuestionFilterScreen extends StatefulWidget {
  const QuestionFilterScreen({super.key});

  @override
  State<QuestionFilterScreen> createState() => _QuestionFilterScreenState();
}

class _QuestionFilterScreenState extends State<QuestionFilterScreen> {
  TextEditingController sectionController = TextEditingController();
  TextEditingController questionNumController = TextEditingController();
  TextEditingController examCodeController = TextEditingController();
  List<int> years =
      List.generate(10, (index) => DateTime.now().year - 5 + index);
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
  int indexMonth = 0;
  int selectedYear = DateTime.now().year;
  String selectedMonth = 'Select Month';
  bool isFormsFilled = true;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: sectionController,
                  decoration: const InputDecoration(hintText: 'Enter Section'),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: questionNumController,
                  decoration:
                      const InputDecoration(hintText: 'Enter Question number'),
                ),
                const SizedBox(
                  height: 30,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 30,
                    color: Colors.redAccent[700],
                  ),
                  value: selectedMonth,
                  onChanged: (newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                      indexMonth = months.indexOf(selectedMonth);
                    });
                  },
                  items: ['Select Month', ...months]
                      .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 30,
                ),
                DropdownButton<int>(
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 30,
                    color: Colors.redAccent[700],
                  ),
                  value: selectedYear,
                  onChanged: (newValue) {
                    setState(() {
                      selectedYear = newValue!;
                    });
                  },
                  items: years
                      .map<DropdownMenuItem<int>>(
                        (value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: examCodeController,
                  decoration: const InputDecoration(hintText: 'Enter Exam code'),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedMonth == 'Select Month' ||
                        sectionController.text == '' ||
                        questionNumController.text == '' ||
                        examCodeController.text == '') {
                          setState(() {
                            isFormsFilled=false;
                          });
                      log('You have to complete all fields');
                    } else {
                      setState(() {
                        isFormsFilled=true;
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => QuestionsScreen(
                                  month: indexMonth,
                                  year: selectedYear,
                                  questionNum: questionNumController.text,
                                  examCode: examCodeController.text,
                                  section: sectionController.text,
                                )),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 130)),
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                !isFormsFilled
                    ? Text(
                        'You have to fill all the fields!',
                        style:
                            TextStyle(fontSize: 18, color: Colors.redAccent[700]),
                      )
                    : const Text('')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
