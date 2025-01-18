import 'package:fashion_admin_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
        backgroundColor: colorTheme,
        onPressed: onPressed,
          
        child: const Icon(
          Icons.add,
          color: whiteColor,
        ),
      );
  }
}