// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter_application_1/Model/live_filter_model.dart';
// import 'package:flutter_application_1/Model/login_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LiveFilterProvider with ChangeNotifier {
//   late Category _categoryData;

//   Category get categoryData => _categoryData;

//   Future<void> postCategoryData(int categoryId, int courseId, String endDate,
//       BuildContext context) async {
//     final tokenProvider = Provider.of<TokenModel>(context, listen: false);
//     final token = tokenProvider.token;

//     final body = jsonEncode({
//       'category_id': categoryId,
//       'course_id': courseId,
//       'end_date': endDate,
//     });

//     try {
//       final response = await http.post(
//         Uri.parse(
//             'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/session_live'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: body,
//       );

//       if (response.statusCode == 200) {
//         Map<String, dynamic> responseData = jsonDecode(response.body);
//         print(responseData);

//         if (responseData != null &&
//             responseData['success'] != null &&
//             responseData['liveRequest'] != null) {
//           _categoryData = Category.fromJson(responseData);
//           notifyListeners();
//         } else {
//           log('error: Response data is null or does not contain expected data');
//         }
//       } else {
//         log('error: HTTP ${response.statusCode} - ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       log('error: $e');
//     }
//   }
// }
