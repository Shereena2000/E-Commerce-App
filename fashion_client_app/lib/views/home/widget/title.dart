import 'package:fashion_client_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final double bottom;
  final double right;

  const CustomTitle({
    required this.title,
    required this.bottom,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      right: right,
      child: Text(
        title,
        style: const TextStyle(
          color: whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }
}
