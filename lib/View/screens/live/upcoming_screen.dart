import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class UpComingScreen extends StatelessWidget {
  const UpComingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'UpComing Live'),
    );
  }
}
