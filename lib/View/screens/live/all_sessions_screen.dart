import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class AllSessionsScreen extends StatelessWidget {
  const AllSessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'All Session'),
    );
  }
}
