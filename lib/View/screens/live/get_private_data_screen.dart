// session_data_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/live/private_live_model.dart';

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
          return ListTile(
            // title: Text(session.lessonSessions),
            // subtitle: Text(session.chapter),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    // title: Text(session.lessonSessions),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Name: ${session.sessionData.name}'),
                        Text('Date: ${session.sessionData.date}'),
                        Text('From: ${session.sessionData.from}'),
                        Text('To: ${session.sessionData.to}'),
                        Text('Type: ${session.sessionData.type}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
