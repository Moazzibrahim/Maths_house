import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/live_filter_service.dart';
import 'package:provider/provider.dart';

class AllSessionsScreen extends StatefulWidget {
  @override
  _AllSessionsScreenState createState() => _AllSessionsScreenState();
}

class _AllSessionsScreenState extends State<AllSessionsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchSessions();
  }

  Future<void> _fetchSessions() async {
    final provider = Provider.of<LiveFilterProvider>(context, listen: false);
    // Sample filter parameters, replace with actual values or dynamic inputs
    await provider.filterLiveSessions(
        1, 1, '2023-01-01', '2023-12-31', context);
  }

  @override
  Widget build(BuildContext context) {
    final sessions = Provider.of<LiveFilterProvider>(context).allSessions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Sessions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: sessions.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  final session = sessions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            session.date,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            session.sessionName,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${session.dateFrom} - ${session.dateTo}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Mr. Amir hemida",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Course: ${session.sessionName}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Chapter: ${session.sessionName}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Lesson: ${session.sessionName}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
