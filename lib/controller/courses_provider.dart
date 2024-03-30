import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_1/Model/courses_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoursesProvider with ChangeNotifier {
  List<Course> allcourses = [];
  Future<void> getCoursesData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;
    try {
      final response = await http.get(Uri.parse(
          'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_courses'),
          headers:{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', 
        },
          );
          if(response.statusCode == 200){
            
            Map<String,dynamic> responseData = jsonDecode(response.body);
            CoursesList cl = CoursesList.fromjson(responseData);
            List<Course> c = cl.courses.map((e) => Course.fromjson(e)).toList();
            allcourses = c;
            notifyListeners();
          }else{
            log('failed to fetch data');
          }
    } catch (e) {
      log('error: $e');
    }
  }
}
