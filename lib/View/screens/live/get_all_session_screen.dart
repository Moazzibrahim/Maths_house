// all_session_data_screen.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/live/private_live_model.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AllSessionDataScreen extends StatelessWidget {
  final List<LiveRequest> sessionData;

  const AllSessionDataScreen({super.key, required this.sessionData});

  Future<void> checkAndLaunchUrl(String url, BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    final response = await http.get(
      Uri.parse(
          'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_link_live'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success'] == 'You Attend Success') {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch URL')),
          );
        }
      } else if (responseData['Sorry'] == 'You Must Buy New Package') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You must buy a new package'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected response from server')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect to server')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Data'),
      ),
      body: ListView.builder(
        itemCount: sessionData.length,
        itemBuilder: (context, index) {
          final session = sessionData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.lessonSessions ?? 'No session name',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    session.chapter ?? 'No chapter',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.red[600]),
                      const SizedBox(width: 5),
                      Text(
                        session.sessionData.name ?? 'No name',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.red[600]),
                      const SizedBox(width: 5),
                      Text(
                        session.sessionData.date != null
                            ? DateFormat('yyyy-MM-dd').format(
                                DateTime.parse(session.sessionData.date!))
                            : 'No date',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.red[600]),
                      const SizedBox(width: 5),
                      Text(
                        'From: ${session.sessionData.from ?? 'No from'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'To: ${session.sessionData.to ?? 'No to'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.red[600]),
                      const SizedBox(width: 5),
                      Text(
                        'Type: ${session.sessionData.type ?? 'No type'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final fromTime = session.sessionData.from;
                          final sessionDate = session.sessionData.date;
                          if (fromTime != null && sessionDate != null) {
                            final sessionDateString = DateFormat('yyyy-MM-dd')
                                .format(DateTime.parse(sessionDate));
                            final fromDateTime =
                                DateTime.parse('$sessionDateString $fromTime');

                            if (fromDateTime
                                .isAfter(now.add(Duration(minutes: 10)))) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'It is too early to join the session'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              final url = session.sessionData.link;
                              if (url != null && url.isNotEmpty) {
                                checkAndLaunchUrl(url, context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('No link available')),
                                );
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('No from time or date available')),
                            );
                          }
                        },
                        child: const Text('Attend'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: faceBookColor, // Text color
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
    );
  }
}
