// session_data_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/live/private_live_model.dart';
import 'package:flutter_application_1/constants/colors.dart';

class SessionDataScreen extends StatelessWidget {
  final List<LiveRequest> sessionData;

  const SessionDataScreen({super.key, required this.sessionData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Data'),
      ),
      body: ListView.builder(
        itemCount: sessionData.length,
        itemBuilder: (context, index) {
          final session = sessionData[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            color: gridHomeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.lessonSessions,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    session.chapter,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey[600]),
                      const SizedBox(width: 5),
                      Text(
                        session.sessionData.name,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.grey[600]),
                      const SizedBox(width: 5),
                      Text(
                        session.sessionData.date,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.grey[600]),
                      const SizedBox(width: 5),
                      Text(
                        'From: ${session.sessionData.from}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'To: ${session.sessionData.to}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.grey[600]),
                      const SizedBox(width: 5),
                      Text(
                        'Type: ${session.sessionData.type}',
                        style: const TextStyle(fontSize: 16),
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
