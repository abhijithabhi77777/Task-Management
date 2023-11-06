import 'package:flutter/material.dart';

import '../utils/styles.dart';


class GradientCircularButton extends StatelessWidget {
  final double size;
  final Function() onPressed;

  const GradientCircularButton({super.key, required this.size, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient:commonGradient,
        ),
        child: Center(
          child: Icon(
            Icons.add, // You can change the icon as needed
            color: Colors.white, // Icon color
            size: size * 0.6, // Adjust the icon size as needed
          ),
        ),
      ),
    );
  }
}