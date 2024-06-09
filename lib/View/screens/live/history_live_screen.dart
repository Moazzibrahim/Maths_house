import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class HistoryLiveScreen extends StatelessWidget {
  const HistoryLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'History Live'),
    );
  }
}
