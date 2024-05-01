import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/Model/quizzes_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class QuizzesProvider with ChangeNotifier {
  List<QuizzesModel> allQuizzesModel= [];
  Future<void> getQuizzesData(BuildContext context, int id) async {
    try{
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
          notifyListeners();
    }else{
      log('error, Staatuscode: ${response.statusCode}');
    }
  }catch(e){
    log('error: $e');
  }
  }

  Future<void> postQuizData(BuildContext context,{required quizId,required score,required timer,required rightQuestion,required mistakes})async{
    try{
      final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    final body = jsonEncode({
      'quizze_id': quizId,
      'score': score,
      'timer': timer,
      'right_question': rightQuestion,
      'mistakes': mistakes,
    });

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
    if(response.statusCode == 200){
      log(response.body);
      log('data posted succesfully');
    }else{
      log('failed with reponseStatus: ${response.statusCode}');
    }
    }catch(e){
      log('Error in post: $e');
    }
  }
}
