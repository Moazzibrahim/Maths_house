// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/chapters_model.dart';
import 'package:flutter_application_1/Model/lessons_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChapterProvider with ChangeNotifier {
  List<Chapter> allChapters = [];
  List<Lesson> allLessons = [];
  List<Videos>? allvideos = [];
  Future<void> getChaptersData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_chapters'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        ChaptersList chaptersList = ChaptersList.fromJson(responseData);
        List<Chapter> c =
            chaptersList.chaptersList.map((e) => Chapter.fromJson(e)).toList();
            allChapters=c;
            notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }
  
  Future<void> getLessonsData(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_lessons'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        LessonsList lessonsList = LessonsList.fromJson(responseData);
        List<Lesson> l =
            lessonsList.lessonsList.map((e) => Lesson.fromJson(e)).toList();
            for(var i in l){
              i.videos.forEach((element) {allvideos!.add(element);});
            }
            log('all videos : ${allvideos!.map((e) => e.videoName)}');
            allLessons=l;
            notifyListeners();
      }
    } catch (e) {
      log('Errorss: $e');
    }
  }

}

