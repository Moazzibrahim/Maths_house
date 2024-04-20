import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.hintText,this.passIcon, required this.isvisText});
  final TextEditingController controller;
  final String hintText;
  final IconButton? passIcon;
  final bool isvisText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 8
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !isvisText,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: passIcon,
          suffixIconColor: Colors.redAccent[700],
        ),
      ),
    );
  }
}