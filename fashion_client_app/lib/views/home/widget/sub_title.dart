
import 'package:fashion_client_app/constants/colors.dart';
import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  final String subtitle;
  final double bottom;
  final double right;

  const Subtitle({
    required this.subtitle,
    required this.bottom,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      right: right,
      child: Text(
        subtitle,
        style: const TextStyle(
          color: whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }
}