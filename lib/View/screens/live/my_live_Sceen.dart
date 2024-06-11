import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/widgets.dart';

class MyLiveScreen extends StatelessWidget {
  const MyLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'My live'),
    );
  }
}
