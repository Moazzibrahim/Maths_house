import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_1/Model/live_filter_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiveFilterProvider with ChangeNotifier {
  late LiveFilter _liveFilterData;
  LiveFilter get liveFilterData => _liveFilterData;
  Future<void> filterLiveSessions(int catId,int courseId,String dateFrom,String dateTo,BuildContext context) async{
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    final body = jsonEncode({
      'category_id' : catId,
      'course_id' : courseId,
      // kamlha nta a ahmed 3shan ziad masha w msh m3aya el keys ... a7la hamo
    });
    try{
      final response = await http.post(
        Uri.parse('https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/session_live'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body
      );
      if(response.statusCode == 200){
        Map<String,dynamic> responseData = jsonDecode(response.body);
        _liveFilterData = LiveFilter.fromJson(responseData);
        notifyListeners();
      }
    }catch(e){
      log('error: $e');
    }
  }
} 