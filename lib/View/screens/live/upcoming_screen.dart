// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/controller/live_provider.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpComingScreen extends StatefulWidget {
  const UpComingScreen({super.key});

  @override
  State<UpComingScreen> createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<LiveProvider>(context, listen: false)
        .getCoursesData(context)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> checkAndLaunchUrl(String url, BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;
    final sesssionIID =
        Provider.of<LiveProvider>(context, listen: false).sessionId;
    final response = await http.get(
      Uri.parse(
          'https://login.mathshouse.net/api/MobileStudent/ApiMyCourses/stu_link_live/$sesssionIID'),
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
          log("session id: $sesssionIID");
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
    return Consumer<LiveProvider>(
      builder: (context, liveProvider, _) {
        final now = DateTime.now();
        final filteredSessions = liveProvider.allsessions.where((session) {
          final sessionDate = session.session.date;
          final toTime = session.session.to;

          if (sessionDate == null || toTime == null) {
            return false;
          }

          final sessionDateString =
              DateFormat('yyyy-MM-dd').format(sessionDate);
          final sessionDateTime = DateTime.parse('$sessionDateString $toTime');
          return sessionDateTime.isAfter(now);
        }).toList();

        return Scaffold(
          appBar: buildAppBar(context, 'Upcoming Live'),
          body: ListView.builder(
            itemCount: filteredSessions.length,
            itemBuilder: (context, index) {
              final session = filteredSessions[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    title: Text(
                      session.session.name ?? 'No name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.red[600]),
                            SizedBox(width: 8.0),
                            Text(
                              'Date: ${session.session.date != null ? DateFormat('yyyy-MM-dd').format(session.session.date!) : 'No date'}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.red[600]),
                            SizedBox(width: 8.0),
                            Text(
                              'From: ${session.session.from ?? 'No from'}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time_filled,
                                color: Colors.red[600]),
                            SizedBox(width: 8.0),
                            Text(
                              'To: ${session.session.to ?? 'No to'}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.info, color: Colors.red[600]),
                            SizedBox(width: 8.0),
                            Text(
                              'Type: ${session.session.type ?? 'No type'}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        final fromTime = session.session.from;
                        final sessionDate = session.session.date;
                        if (fromTime != null && sessionDate != null) {
                          final sessionDateString =
                              DateFormat('yyyy-MM-dd').format(sessionDate);
                          final fromDateTime =
                              DateTime.parse('$sessionDateString $fromTime');

                          if (fromDateTime
                              .isAfter(now.add(Duration(minutes: 10)))) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('It is too early to join the session'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            final url = session.session.link;
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
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: faceBookColor, // Text color
                      ),
                      child: Text('Attend'),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

Future<void> launchUrl(Uri url) async {
  if (await canLaunch(url.toString())) {
    await launch(url.toString());
  } else {
    throw 'Could not launch $url';
  }
}
