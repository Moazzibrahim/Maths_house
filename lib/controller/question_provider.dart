import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_1/Model/question_filter_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:provider/provider.dart';

class QuestionsProvider with ChangeNotifier{
  List<Question> allQuestions = [];
  Future<void> getQuestionsData(BuildContext context)async{
    try{
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_question_filter'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        QuestionsList questionsList = QuestionsList.fromJson(responseData);
        List<Question> q =
            questionsList.questionsList.map((e) => Question.fromJson(e)).toList();
            allQuestions=q;
            notifyListeners();
      }
    }catch(e){
      log('Error: $e');
    }
  }
}