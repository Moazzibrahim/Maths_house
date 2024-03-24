import 'package:flutter/material.dart';

class GridContainer extends StatelessWidget {
  const GridContainer({super.key, required this.text, required this.color, required this.styleColor});
  final String text;
  final Color? color;
  final Color? styleColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style:  TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: styleColor
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
