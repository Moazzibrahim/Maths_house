import 'package:flutter/material.dart';

class CarouselContainer extends StatelessWidget {
  const CarouselContainer({super.key, required this.color, required this.text, required this.image});
  final Color color;
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
          SizedBox(
            width: 190,
            height: 150,
            child: Image.asset(image,),
            )
        ],
      ),
    );
  }
}