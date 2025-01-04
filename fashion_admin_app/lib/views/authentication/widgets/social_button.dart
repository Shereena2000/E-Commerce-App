import 'package:fashion_admin_app/constants/colors.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String imagePath;
  final String title;
 
  final bool useWhiteBackground;
final VoidCallback onPressed; 
  SocialButton({
    super.key, required this.imagePath, required this.title,required this.onPressed,required this.useWhiteBackground
  });
 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Image.asset(
      imagePath,
      ),
      onPressed: onPressed,
      label: Text(title),
      style: ElevatedButton.styleFrom(backgroundColor:useWhiteBackground?whiteColor:beigeColor),
    );
  }
}
