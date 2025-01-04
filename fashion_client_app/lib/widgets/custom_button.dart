     import 'package:fashion_client_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Gradient gradient;
  final Icon? icon;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 45,
    this.width = 120,
    this.gradient = linearBlacColor,
    this.icon,
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
     