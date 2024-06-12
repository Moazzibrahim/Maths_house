import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/history_models/dia_exam_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DiaExamHistoryProvider with ChangeNotifier {
  List<DiaExamHistory> allDiaExam = [];
  List<DiaExamReccomendation> allze = [];
  List<String> chapterName = [];
  List<int> idddddd = [];
  List<double> pricess = [];
  List<int> durations = [];
  List<double> discounts = [];

  Future<void> getDiaExamHistory(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_history'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        DiaExamHistoryList diaexamHistoryList =
            DiaExamHistoryList.fromJson(responseData);
        List<DiaExamHistory> d = diaexamHistoryList.diaExamList
            .map((e) => DiaExamHistory.fromJson(e))
            .toList();
        allDiaExam = d;
        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> getDiaExamHistoryrecommendation(
      BuildContext context, int id) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_dia_exam_mistakes/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        DiaExamReccomendationList diaexamHistoryList =
            DiaExamReccomendationList.fromJson(responseData);
        List<DiaExamReccomendation> d = diaexamHistoryList
            .diaExamReccomendationList
            .map((e) => DiaExamReccomendation.fromJson(e))
            .toList();
        allze = d;

        // Clear previous data
        chapterName.clear();
        idddddd.clear();
        pricess.clear();
        durations.clear();
        discounts.clear();

        Set<int> uniqueDurations = {};

        // Populate lists with new data
        for (var recommendation in d) {
          chapterName.add(recommendation.chapterName);
          idddddd.add(recommendation.id);
          for (var price in recommendation.diaPrices) {
            if (!uniqueDurations.contains(price.duration)) {
              uniqueDurations.add(price.duration);
              pricess.add(price.price.toDouble());
              durations.add(price.duration);
              discounts.add(price.discount.toDouble());
            }
          }
        }

        log('d: $d');
        log('chapterName: $chapterName');
        log('idddddd: $idddddd');
        log('pricess: $pricess');
        log('durations: $durations');
        log('discounts: $discounts');

        notifyListeners();
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
