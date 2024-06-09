import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class PrivateLiveScreen extends StatelessWidget {
  const PrivateLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Private Live'),
    );
  }
}
