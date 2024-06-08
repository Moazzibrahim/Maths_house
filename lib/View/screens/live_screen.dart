import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/live_model.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/live_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<LiveProvider>(context, listen: false).getCoursesData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: const Text(
            'Live Sessions',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          color: faceBookColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<LiveProvider>(
          builder: (context, liveProvider, _) {
            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    indicator: BoxDecoration(
                      color: Colors.redAccent[700],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.redAccent[700],
                    tabs: const [
                      _CustomTab(text: 'Upcoming Sessions'),
                      _CustomTab(text: 'History'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildSessionsList(
                          liveProvider,
                          liveProvider.allsessions
                              .where((session) =>
                                  session.session.date!.isAfter(DateTime.now()))
                              .toList(),
                          isUpcoming: true,
                        ),
                        _buildSessionsList(
                          liveProvider,
                          liveProvider.allsessions
                              .where((session) => session.session.date!
                                  .isBefore(DateTime.now()))
                              .toList(),
                          isUpcoming: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSessionsList(LiveProvider liveProvider, List<Session> sessions,
      {required bool isUpcoming}) {
    final dateFormat = DateFormat('dd MMMM yyyy');
    final currentTime = DateTime.now();

    if (liveProvider.mustBuyNewPackage && isUpcoming) {
      return Center(
        child: Text(
          'Sorry: You Must Buy New Package',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      );
    }

    if (sessions.isEmpty) {
      return Center(
        child: Text(
          isUpcoming ? 'No upcoming sessions' : 'No past sessions',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        final sessionTime = session.session.date!;
        final isBeforeStart =
            currentTime.isBefore(sessionTime.subtract(Duration(minutes: 10)));
        final isDuringSession = currentTime.isAfter(sessionTime) &&
            currentTime.isBefore(sessionTime
                .add(Duration(hours: 1))); // Assuming session lasts for 1 hour

        return ListTile(
          title: Text(
            session.session.name ?? 'No Name',
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date: ${dateFormat.format(sessionTime)}",
                style: TextStyle(),
              ),
              Text("From: ${session.session.from}"),
              Text("To: ${session.session.to}"),
            ],
          ),
          trailing: isUpcoming
              ? ElevatedButton(
                  onPressed: isBeforeStart
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: faceBookColor,
                              content:
                                  Text("It's too early to attend the session!"),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      : isDuringSession
                          ? () => _launchURL(session.session.link!)
                          : null, // Attend button should be null if the session is not during the session time
                  child: const Text(
                    "Attend",
                    style: TextStyle(
                        color: faceBookColor, fontWeight: FontWeight.bold),
                  ),
                )
              : null,
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class _CustomTab extends StatelessWidget {
  final String text;

  const _CustomTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
