// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/live_model.dart';
import 'package:flutter_application_1/controller/live_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({Key? key}) : super(key: key);

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
        title: const Text(
          'Live Sessions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<LiveProvider>(
          builder: (context, liveProvider, _) {
            if (liveProvider.allsessions.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: [
                  _buildSectionUpcoming(
                      "Upcoming Sessions",
                      liveProvider.allsessions
                          .where((session) =>
                              session.session.date.isAfter(DateTime.now()))
                          .toList()), // Filter upcoming sessions
                  _buildSectionHistory(
                      "History",
                      liveProvider.allsessions
                          .where((session) =>
                              session.session.date.isBefore(DateTime.now()))
                          .toList()), // Filter past sessions
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSectionUpcoming(String title, List<Session> sessions) {
    final dateFormat = DateFormat('dd MMMM yyyy');

    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      children: sessions.map((session) {
        return ListTile(
          title: Text(session.session.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Date: ${dateFormat.format(session.session.date)}"), // Format date here
              Text("From: ${session.session.from}"),
              Text("To: ${session.session.to}"),
              GestureDetector(
                child: Text(
                  "link: ${session.session.link}",
                  style: TextStyle(
                      color: Colors.blue[800],
                      decoration: TextDecoration.underline),
                ),
                onTap: () => _launchURL(session.session.link),
              ),
            ],
          ),
          trailing: ElevatedButton(
            onPressed: () {
              // Handle attend button press
            },
            child: const Text("Attend"),
          ),
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (ctx) => ChaptersScreen(title: session.session.name, course: session,))
            // );
          },
        );
      }).toList(),
    );
  }
  
  Widget _buildSectionHistory(String title, List<Session> sessions) {
    final dateFormat = DateFormat('dd MMMM yyyy');

    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      children: sessions.map((session) {
        return ListTile(
          title: Text(session.session.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Date: ${dateFormat.format(session.session.date)}"), // Format date here
              Text("From: ${session.session.from}"),
              Text("To: ${session.session.to}"),
              GestureDetector(
                child: Text(
                  "link: ${session.session.link}",
                  style: TextStyle(
                      color: Colors.blue[800],
                      decoration: TextDecoration.underline),
                ),
                onTap: () => _launchURL(session.session.link),
              ),
            ],
          ),
        );
      }).toList(),
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
