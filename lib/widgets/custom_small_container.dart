import 'package:flutter/material.dart';

class CustomSmallCard extends StatelessWidget {
  const CustomSmallCard({super.key, required this.icon, required this.color, required this.text, required this.iconColor});
  final IconData icon;
  final Color? iconColor;
  final Color? color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: iconColor,size: 35,),
          const SizedBox(height: 10,),
          Text(text,style: const TextStyle(fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}