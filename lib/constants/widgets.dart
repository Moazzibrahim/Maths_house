import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

AppBar buildAppBar(BuildContext context){
  return AppBar(
        centerTitle: true,
        title: const Text(
          'Questions History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: gridHomeColor, borderRadius: BorderRadius.circular(12)),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.redAccent[700],
            ),
          ),
        ),
      );
}