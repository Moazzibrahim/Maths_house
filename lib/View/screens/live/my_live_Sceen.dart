import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/live/my_live_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/View/screens/live/my_live_start_quiz.dart';
import 'package:flutter_application_1/View/screens/live/video_live.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

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
  _MyLiveScreenState createState() => _MyLiveScreenState();
}

class _MyLiveScreenState extends State<MyLiveScreen> {
  late Future<List<MyLiveSession>> futureMyLiveSessions;
  String? selectedCourseName;

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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No live sessions found'));
          } else {
            final sessions = snapshot.data!;

            return FutureBuilder<List<String>>(
              future: _getUniqueCourseNames(sessions),
              builder: (context, courseNamesSnapshot) {
                if (courseNamesSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (courseNamesSnapshot.hasError) {
                  return Center(
                      child: Text('Error: ${courseNamesSnapshot.error}'));
                } else if (!courseNamesSnapshot.hasData ||
                    courseNamesSnapshot.data!.isEmpty) {
                  return const Center(child: Text('No courses available'));
                } else {
                  final courseNames = courseNamesSnapshot.data!;
                  final filteredSessions = selectedCourseName == null
                      ? []
                      : sessions.where((session) {
                          return session.session?.lesson?.chapterMyLive?.course
                                  ?.courseName ==
                              selectedCourseName;
                        }).toList();

                  return Column(
                    children: [
                      // Dropdown for selecting the course name
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            color: gridHomeColor,
                            borderRadius:
                                BorderRadius.circular(12.0), // Rounded corners
                            border: Border.all(
                                color: faceBookColor), // Border color
                          ),
                          child: DropdownButtonHideUnderline(
                            // Hides the default underline
                            child: DropdownButton<String>(
                              value: selectedCourseName,
                              hint: Text(
                                'Select Course',
                                style: TextStyle(
                                  color: faceBookColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCourseName = newValue;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: faceBookColor),
                              isExpanded:
                                  true, // Makes the dropdown fill the width
                              items: courseNames.map((courseName) {
                                return DropdownMenuItem<String>(
                                  value: courseName,
                                  child: Text(
                                    courseName,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: selectedCourseName == null
                            ? Center(
                                child: Text(
                                    'Please select a course to see live sessions'))
                            : filteredSessions.isEmpty
                                ? Center(
                                    child: Text(
                                        'No live sessions available for the selected course'))
                                : ListView.builder(
                                    itemCount: filteredSessions.length,
                                    itemBuilder: (context, index) {
                                      final session = filteredSessions[index];
                                      final lesson = session.session?.lesson;
                                      final chapter = lesson?.chapterMyLive;

                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        elevation: 4.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 8),
                                              Text(
                                                chapter?.chapterName ??
                                                    'No chapter',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                lesson?.lessonName ??
                                                    'No lesson',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(height: 5.h),
                                              if (selectedCourseName != null)
                                                Text(
                                                  'name: ${session.session?.name ?? 'No session name'}',
                                                  style: TextStyle(
                                                      fontSize: 18.0.sp),
                                                ),
                                              SizedBox(height: 5.h),
                                              if (selectedCourseName != null)
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.calendar_today,
                                                        color: faceBookColor),
                                                    SizedBox(width: 5.w),
                                                    Text(
                                                      'Date: ${_formatDate(session.session?.date)}',
                                                      style: TextStyle(
                                                          fontSize: 16.sp),
                                                    ),
                                                  ],
                                                ),
                                              SizedBox(height: 5.h),
                                              if (selectedCourseName != null)
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.access_time,
                                                        color: faceBookColor),
                                                    SizedBox(width: 5.w),
                                                    Text(
                                                      'From: ${session.session?.from ?? 'no from'}',
                                                      style: TextStyle(
                                                          fontSize: 16.sp),
                                                    ),
                                                    SizedBox(width: 10.w),
                                                    Text(
                                                      'To: ${session.session?.to ?? 'No to'}',
                                                      style: TextStyle(
                                                          fontSize: 16.sp),
                                                    ),
                                                  ],
                                                ),
                                              SizedBox(height: 5.h),
                                              if (selectedCourseName != null)
                                                Row(
                                                  children: [
                                                    const Icon(Icons.info,
                                                        color: faceBookColor),
                                                    SizedBox(width: 5.w),
                                                    Text(
                                                      'Type: ${session.session?.type ?? 'No type'}',
                                                      style: TextStyle(
                                                          fontSize: 16.sp),
                                                    ),
                                                  ],
                                                ),
                                              SizedBox(height: 5.h),
                                              if (selectedCourseName != null)
                                                Wrap(
                                                  spacing:
                                                      8.0, // Gap between adjacent buttons
                                                  runSpacing:
                                                      4.0, // Gap between lines if wrapped
                                                  children: [
                                                    ElevatedButton.icon(
                                                      onPressed: () {
                                                        if (lesson != null &&
                                                            lesson.lessonUrl !=
                                                                null) {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VideoWebView(
                                                                      url: lesson
                                                                          .lessonUrl!),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons
                                                              .play_circle_filled,
                                                          color: Colors.white),
                                                      label: const Text(
                                                          'Video lesson'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            faceBookColor,
                                                      ),
                                                    ),
                                                    ElevatedButton.icon(
                                                      onPressed: () {
                                                        if (session.session
                                                                ?.materialLink !=
                                                            null) {
                                                          _launchURL(session
                                                              .session
                                                              ?.materialLink);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.video_library,
                                                          color: Colors.white),
                                                      label: const Text(
                                                          'Video record'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            faceBookColor,
                                                      ),
                                                    ),
                                                    ElevatedButton.icon(
                                                      onPressed: () {
                                                        if (session.session
                                                                ?.materialLink !=
                                                            null) {
                                                          _launchURL(session
                                                              .session
                                                              ?.materialLink);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.picture_as_pdf,
                                                          color: Colors.white),
                                                      label: const Text(
                                                          'Download PDF'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            faceBookColor,
                                                      ),
                                                    ),
                                                    ElevatedButton.icon(
                                                      onPressed: () {
                                                        if (lesson != null) {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MyLiveStartQuiz(
                                                                lessonId:
                                                                    lesson.id!,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.quiz,
                                                          color: Colors.white),
                                                      label: const Text(
                                                          'Start Quiz'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            faceBookColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> _getUniqueCourseNames(
      List<MyLiveSession> sessions) async {
    final Set<String> courseNames = {};
    for (var session in sessions) {
      final courseName =
          session.session?.lesson?.chapterMyLive?.course?.courseName;
      if (courseName != null) {
        courseNames.add(courseName);
      }
    }
    return courseNames.toList();
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'No date';
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }

  Future<void> _launchURL(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
