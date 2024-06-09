import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/widgets.dart';
import 'package:flutter_application_1/controller/live_provider.dart';
import 'package:provider/provider.dart';

class UpComingScreen extends StatefulWidget {
  const UpComingScreen({super.key});

  @override
  State<UpComingScreen> createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen> {
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
          appBar: buildAppBar(context, 'UpComing Live'),
          body: Consumer<LiveProvider>(
            builder: (context, liveProvider, _) {
              return ListView.builder(
                itemCount: liveProvider.allsessions.length,
                itemBuilder: (context, index) {
                  final session = liveProvider.allsessions[index];
                  return ListTile(
                    title: Text(session.session.name ?? 'No name'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${session.session.date ?? 'No date'}'),
                        Text('From: ${session.session.from ?? 'No from'}'),
                        Text('To: ${session.session.to ?? 'No to'}'),
                        Text('Link: ${session.session.link ?? 'No link'}'),
                      ],
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
}
