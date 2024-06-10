import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/live_filter_model.dart';

class LiveSessionDetailsScreen extends StatelessWidget {
  
  final LiveRequest liveRequest;

  const LiveSessionDetailsScreen({super.key, required this.liveRequest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Session Details'),
      ),
      body: ListView.builder(
        itemCount: liveRequest.liveRequest.length,
        itemBuilder: (context, index) {
          final lessonData = liveRequest.liveRequest[index];
          return ExpansionTile(
            title: Text(lessonData.chapter),
            children: [
              ListTile(
                title: Text('Lesson Sessions: ${lessonData.lessonSessions}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Session Name: ${lessonData.sessionData.name}'),
                    Text('Date: ${lessonData.sessionData.date}'),
                    Text('From: ${lessonData.sessionData.from}'),
                    Text('To: ${lessonData.sessionData.to}'),
                    Text('Link: ${lessonData.sessionData.link}'),
                    Text('Material Link: ${lessonData.sessionData.materialLink}'),
                    Text('Type: ${lessonData.sessionData.type}'),
                    Text('Price: ${lessonData.sessionData.price}'),
                    Text('Access Days: ${lessonData.sessionData.accessDays}'),
                    Text('Repeat: ${lessonData.sessionData.repeat}'),
                    Text('Created At: ${lessonData.sessionData.createdAt}'),
                    Text('Updated At: ${lessonData.sessionData.updatedAt}'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
