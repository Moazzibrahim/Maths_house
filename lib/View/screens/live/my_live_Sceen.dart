// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/live/my_live_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

// Define your models (MyLiveSession, Session, Lesson, etc.) here or import them if defined in a separate file

Future<List<MyLiveSession>> fetchMyLiveSessions(BuildContext context) async {
  final tokenProvider = Provider.of<TokenModel>(context, listen: false);
  final token = tokenProvider.token;
  final response = await http.get(
    Uri.parse(
        'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/myLive_session'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return myLiveSessionFromJson(response.body);
  } else {
    throw Exception('Failed to load myLiveSessions');
  }
}

class MyLiveScreen extends StatefulWidget {
  const MyLiveScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyLiveScreenState createState() => _MyLiveScreenState();
}

class _MyLiveScreenState extends State<MyLiveScreen> {
  late Future<List<MyLiveSession>> futureMyLiveSessions;

  @override
  void initState() {
    super.initState();
    futureMyLiveSessions = fetchMyLiveSessions(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'My live'),
      body: FutureBuilder<List<MyLiveSession>>(
        future: futureMyLiveSessions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No live sessions found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final session = snapshot.data![index];
                final lesson = session.session?.lesson;
                final chapter = lesson?.chapterMyLive;

                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          chapter?.chapterName ?? 'No chapter',
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          lesson?.lessonName ?? 'No lesson',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'name: ${session.session?.name ?? 'No session name'}',
                          style: TextStyle(
                            fontSize: 18.0.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: faceBookColor),
                            SizedBox(width: 5.w),
                            Text(
                              'Date:${_formatDate(session.session?.date)}', // Use the helper function here
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: faceBookColor),
                            const SizedBox(width: 5),
                            Text(
                              'From: ${session.session?.from ?? 'no from'}',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'To: ${session.session?.to ?? 'No to'}',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(Icons.info, color: faceBookColor),
                            SizedBox(width: 5.w),
                            Text(
                              'Type: ${session.session?.type ?? 'No type'}',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Wrap(
                          spacing: 8.0, // Gap between adjacent buttons
                          runSpacing: 4.0, // Gap between lines if wrapped
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                _launchURL(lesson?.lessonUrl);
                              },
                              icon: Icon(Icons.play_circle_filled,
                                  color: Colors.white),
                              label: Text('Video lesson'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: faceBookColor,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                if (lesson!.ideas!.isNotEmpty &&
                                    lesson.ideas?.first.vLink != null) {
                                  _launchURL(lesson.ideas?.first.vLink);
                                }
                              },
                              icon: Icon(Icons.video_library,
                                  color: Colors.white),
                              label: Text('Video record'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: faceBookColor,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                if (lesson!.ideas!.isNotEmpty) {
                                  _launchURL(lesson.ideas!.first.pdf);
                                }
                              },
                              icon: Icon(Icons.picture_as_pdf,
                                  color: Colors.white),
                              label: Text('Download PDF'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: faceBookColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _launchURL(String? url) async {
    if (url != null) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  // Helper function to format the date
  String _formatDate(DateTime? date) {
    if (date == null) return 'No date';
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }
}
