
import 'package:fashion_client_app/constants/colors.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String imagePath;
 
final VoidCallback onPressed; 
  SocialButton({
    super.key, required this.imagePath, 

    required this.onPressed,
  
  });
 
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
     
      child: ClipOval(child: Image.asset(imagePath),),
      onPressed: onPressed,
    
      style: ElevatedButton.styleFrom(shape: CircleBorder(),backgroundColor:whiteColor
   
      ),
    );
  }
}
