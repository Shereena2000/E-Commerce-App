import 'package:fashion_admin_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final Icon? icon;
  const CustomOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonWidth = screenWidth * 0.6;
    final buttonHeight = screenHeight * 0.06;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: beigeColor,
            borderRadius: BorderRadius.circular(28)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (icon != null) ...[
                icon!,
              ],
              Text(
                text,
                style: const TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
