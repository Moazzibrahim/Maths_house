import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

class Price {
  final int id;
  final int duration;
  final double price;
  final double discount;
  final int chapterId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Price({
    required this.id,
    required this.duration,
    required this.price,
    required this.discount,
    required this.chapterId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json['id'],
      duration: json['duration'],
      price: json['price'].toDouble(),
      discount: json['discount'].toDouble(),
      chapterId: json['chapter_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Recommendation {
  final int id;
  final String chapterName;
  final int courseId;
  final String chDes;
  final String chUrl;
  final String preRequisition;
  final String gain;
  final int teacherId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String type;
  final List<Price> prices;

  Recommendation({
    required this.id,
    required this.chapterName,
    required this.courseId,
    required this.chDes,
    required this.chUrl,
    required this.preRequisition,
    required this.gain,
    required this.teacherId,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.prices,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    var priceList = json['price'] as List;
    List<Price> priceObjs =
        priceList.map((priceJson) => Price.fromJson(priceJson)).toList();

    return Recommendation(
      id: json['id'],
      chapterName: json['chapter_name'],
      courseId: json['course_id'],
      chDes: json['ch_des'],
      chUrl: json['ch_url'],
      preRequisition: json['pre_requisition'],
      gain: json['gain'],
      teacherId: json['teacher_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      type: json['type'],
      prices: priceObjs,
    );
  }
}

class ApiResponse {
  final bool grade;
  final int score;
  final List<Recommendation> recommendations;

  ApiResponse({
    required this.grade,
    required this.score,
    required this.recommendations,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var recommendationList = json['recommandition'] as List;
    List<Recommendation> recommendationObjs = recommendationList
        .map(
            (recommendationJson) => Recommendation.fromJson(recommendationJson))
        .toList();

    return ApiResponse(
      grade: json['grade'],
      score: json['score'],
      recommendations: recommendationObjs,
    );
  }
} 

class GetCourseProvider with ChangeNotifier {
  Future<Map<String, dynamic>> fetchDataFromApi(
      Map<String, dynamic> requestData, BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    String queryParams = '';
    requestData.forEach((key, value) {
      if (queryParams.isNotEmpty) {
        queryParams += '&';
      }
      queryParams += '$key=$value';
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_dia_grade?$queryParams'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<void> sendChapterDetails(
      List<Map<String, dynamic>> chapterDetails, BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      final response = await http.post(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/sendChapterDetails'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'chapterDetails': chapterDetails}),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully');
      } else {
        throw Exception('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending data: $e');
    }
  }
}
