import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/Model/quizzes_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class QuizzesProvider with ChangeNotifier {
  List<QuizzesModel> allQuizzesModel = [];
  bool isQuizEntered = false;
  String message= '';
  Future<void> getQuizzesData(BuildContext context, int id) async {
    try {
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_quiz/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        QuizzesModelList quizzesModelList =
            QuizzesModelList.fromJson(responseData);
        List<QuizzesModel> ql = quizzesModelList.quizzesModelList
            .map((e) => QuizzesModel.fromJson(e))
            .toList();
        allQuizzesModel = ql;
        log('${allQuizzesModel.map((e) => e.id)}');
        notifyListeners();
      } else {
        log('error, Staatuscode: ${response.statusCode}');
      }
    } catch (e) {
      log('error: $e');
    }
  }

  Future<void> postQuizData(BuildContext context,
      {required quizId,
      required score,
      required timer,
      required rightQuestion,
      required mistakes}) async {
    try {
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;
      final body = jsonEncode({
        'quizze_id': quizId,
        'score': score,
        'timer': timer,
        'right_question': rightQuestion,
        'mistakes': mistakes,
      });
      log(body);
      log(mistakes);

      final response = await http.post(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_quiz_grade'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        log(response.body);
        log('data posted succesfully');
      } else {
        log(response.body);
        log('failed with reponseStatus: ${response.statusCode}');
      }
    } catch (e) {
      log('Error in post: $e');
    }
  }

  Future<void> startQuizCheck(BuildContext context,int lessonId,int quizId) async{
  try {
      bool isEntered = false;
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
      final token = tokenProvider.token;
      final body = jsonEncode({
        'lesson_id': lessonId ,
        'quiz_id' : quizId,
      });
      final response = await http.post(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_check_quiz'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      if(response.statusCode == 200){
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        
        if(responseData.containsKey('success')){
          isEntered = false;
        }else{
          isEntered = true;
        }
        message = responseData['success'];
        isQuizEntered = isEntered;
        notifyListeners();
      }else{
        log('failed with statuscode: ${response.statusCode}');
      }
  } catch (e) {
    log('Error in post: $e');
  }
}
}
