import 'package:fashion_admin_app/constants/Texts.dart';
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Gradient gradient;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 45,
    this.width = 120,
    this.gradient = linearBrownColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: gradient, borderRadius: BorderRadius.circular(23)),
        child: Center(
          child: Text(text, style: buttonText),
        ),
      ),
    );
  }
}
