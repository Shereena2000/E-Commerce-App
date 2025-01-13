
import 'package:fashion_client_app/constants/colors.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String imagePath;
  // final String title;
 
  // final bool useWhiteBackground;
final VoidCallback onPressed; 
  SocialButton({
    super.key, required this.imagePath, 
    // required this.title,
    required this.onPressed,
    // required this.useWhiteBackground
  });
 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // icon: Image.asset(
      // imagePath,
      // ),
      child: ClipOval(child: Image.asset(imagePath),),
      onPressed: onPressed,
      // label: Text(title),
      style: ElevatedButton.styleFrom(shape: CircleBorder(),backgroundColor:whiteColor
      // useWhiteBackground?whiteColor:blackColor,
      ),
    );
  }
}
