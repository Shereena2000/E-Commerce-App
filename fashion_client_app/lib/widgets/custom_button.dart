     import 'package:fashion_client_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  // final double height;
  // final double width;
  final Gradient gradient;
  final Icon? icon;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    // this.height = 45,
    // this.width = 120,
    this.gradient = linearBlacColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Set width and height based on screen size with a fallback to default
    final buttonWidth = screenWidth * 0.6; // 30% of screen width
    final buttonHeight =  screenHeight * 0.06;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height:buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
            gradient: gradient, borderRadius: BorderRadius.circular(28)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (icon != null) ...[
                icon!,
              ],
              Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
     