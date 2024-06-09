import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_1/Model/live_filter_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiveFilterProvider with ChangeNotifier {
  late LiveFilter _liveFilterData;
  List<SessionLive> _allSessions = [];

  LiveFilter get liveFilterData => _liveFilterData;
  List<SessionLive> get allSessions => _allSessions;

  Future<void> filterLiveSessions(int catId, int courseId, String dateFrom,
      String dateTo, BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    final body = jsonEncode({
      'category_id': catId,
      'course_id': courseId,
      'start_date': dateFrom,
      'end_date': dateTo,
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/session_live'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);

        // Ensure responseData is not null and has expected structure
        if (responseData != null) {
          _liveFilterData = LiveFilter.fromJson(responseData);
          _allSessions = _liveFilterData.courseLiveList
              .expand((course) => course.chapterLiveList)
              .expand((chapter) => chapter.lessonLiveList)
              .expand((lesson) => lesson.sessionLiveList)
              .toList();
          notifyListeners();
        } else {
          log('error: Response data is null or does not contain expected data');
        }
      } else {
        log('error: HTTP ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      log('error: $e');
    }
  }
}
