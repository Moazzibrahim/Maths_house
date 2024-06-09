// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/live_provider.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HistoryLiveScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const HistoryLiveScreen({Key? key}) : super(key: key);

  @override
  State<HistoryLiveScreen> createState() => _HistoryLiveScreenState();
}

class _HistoryLiveScreenState extends State<HistoryLiveScreen> {
  @override
  void initState() {
    Provider.of<LiveProvider>(context, listen: false)
        .getCoursesData(context)
        .catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LiveProvider>(
      builder: (context, packageProvider, _) {
        return Scaffold(
          appBar: buildAppBar(context, ' Live History'),
          body: Consumer<LiveProvider>(
            builder: (context, liveProvider, _) {
              final now = DateTime.now();
              final pastSessions = liveProvider.allsessions.where((session) {
                final sessionDate = session.session.date;
                print("session date: $sessionDate");
                final sessionFrom = session.session.from;
                final sessionTo = session.session.to;
                if (sessionDate == null ||
                    sessionFrom == null ||
                    sessionTo == null) return false; // Handle null cases
                final parsedDate = DateTime.parse(sessionDate.toString());
                final parsedFromTime = _parseTime(sessionFrom);
                final parsedToTime = _parseTime(sessionTo);
                if (parsedDate != null &&
                    parsedFromTime != null &&
                    parsedToTime != null) {
                  final sessionEndDateTime = DateTime(
                    parsedDate.year,
                    parsedDate.month,
                    parsedDate.day,
                    parsedToTime.hour,
                    parsedToTime.minute,
                  );
                  // Check if the session end time is before the current time or ended within the last one minute
                  return sessionEndDateTime.isBefore(now) ||
                      sessionEndDateTime.isAtSameMomentAs(
                          now.subtract(const Duration(minutes: 1)));
                }
                return false;
              }).toList();
              return pastSessions.isEmpty
                  ? const Center(
                      child: Text(
                        'No past sessions found.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: pastSessions.length,
                      itemBuilder: (context, index) {
                        final session = pastSessions[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListTile(
                              title: Text(session.session.name ?? 'No name'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          color: Colors.grey, size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Date: ${DateFormat('yyyy-MM-dd').format(session.session.date ?? DateTime.now())}',
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time,
                                          color: Colors.green, size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        'From: ${session.session.from ?? 'No from'}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time,
                                          color: Colors.red, size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        'To: ${session.session.to ?? 'No to'}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        );
      },
    );
  }

  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
