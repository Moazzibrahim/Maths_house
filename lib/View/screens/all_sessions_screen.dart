import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/live_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AllSessionsScreen extends StatelessWidget {

  const AllSessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final liveProvider = Provider.of<LiveProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Design Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildCustomDesign(liveProvider),
      ),
    );
  }

  Widget _buildCustomDesign(LiveProvider liveProvider) {
    final sessions =
        liveProvider.allsessions; // Use all sessions for custom design

    return ListView.builder(
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        final sessionDate = session.session.date!;
        final dayOfWeek = DateFormat('EEEE').format(sessionDate);
        final monthDay = DateFormat('MMMM dd').format(sessionDate);
        final timeRange = "${session.session.from} / ${session.session.to}";

        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  monthDay,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  dayOfWeek,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  timeRange,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Mr. Ahmed Al-Basha",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Course: History",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Chapter: 1",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Lesson: 3",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
