import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridContainer extends StatelessWidget {
  const GridContainer(
      {super.key,
      required this.text,
      required this.color,
      required this.styleColor,
      required this.image});
  final String text;
  final Color? color;
  final Color? styleColor;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 20,
                      color: styleColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Image.asset(image,height: 50,)
        ],
      ),
    );
  }
}
