     import 'package:fashion_client_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final Gradient gradient;
  final Icon? icon;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
 
    this.gradient = linearBlacColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonWidth = screenWidth * 0.6; 
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
     