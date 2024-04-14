// ignore_for_file: use_super_parameters, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/screens/Diagnostic_exams/diagnostic_exam_results.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/diagnostic_filteration_provider.dart';
import 'package:provider/provider.dart';

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
    Provider.of<DiagnosticFilterationProvider>(context, listen: false)
        .fetchdiagdata(context);
  }

  // Future<void> sendFiltersToServer() async {
  //   final tokenProvider = Provider.of<TokenModel>(context, listen: false);
  //   final token = tokenProvider.token;
  //   // Construct the request body with selected filter values
  //   final Map<String, dynamic> requestBody = {
  //     'category': _selectedCategory,
  //     'course': _selectedCourse,
  //   };

  //   final url = Uri.parse(
  //       'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_filter_exam_process');

  //   try {
  //     // Send a POST request to the server
  //     final response = await http.post(
  //       url,
  //       body: jsonEncode(requestBody),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //         // Add any additional headers if required
  //       },
  //     );

  //     // Check if the request was successful (status code 200)
  //     if (response.statusCode == 200) {
  //       // Request was successful, handle the response here
  //       print('Filters sent successfully!');
  //       print('Response body: ${response.body}');
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const DiagnosticExamResults(),
  //         ),
  //       );
  //     } else {
  //       // Request failed, handle error here
  //       print('Failed to send filters. Status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     // Handle any errors that occur during the HTTP request
  //     print('Error sending filters: $error');
  //   }
  // }

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
                      const SizedBox(height: 20), // Adjust as needed
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
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DiagnosticExamResults(),
                            ),
                          );
                          print('Category: $_selectedCategory');
                          print('Course: $_selectedCourse');
                        },
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
                );
        },
      ),
    );
  }
}
