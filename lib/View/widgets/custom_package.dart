import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class CustomPackage extends StatefulWidget {
  const CustomPackage({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
  }) : super(key: key);

  final String text1, text2, text3;

  @override
  _CustomPackageState createState() => _CustomPackageState();
}

class _CustomPackageState extends State<CustomPackage> {
  Map<int, bool> isSelected = {};

  void selectContainer(int index) {
    setState(() {
      isSelected[index] = !(isSelected[index] ?? false);
    });
  }

  void resetSelection() {
    setState(() {
      isSelected.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => selectContainer(widget.key.hashCode),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected[widget.key.hashCode] ?? false
                ? gridHomeColor
                : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          width: double.maxFinite,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text1,
                  style: const TextStyle(color: faceBookColor, fontSize: 20),
                ),
                Text(
                  widget.text2,
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                Text(
                  widget.text3,
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
