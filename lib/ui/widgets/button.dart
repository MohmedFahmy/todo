import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';


class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.label, required this.onTap})
    : super(key: key);
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryClr,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
