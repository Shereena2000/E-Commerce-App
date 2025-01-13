import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/constants/texts.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key,this.title = 'Sign In',
    this.subtitle = 'Hi! Welcome back, you’ve been missed',});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [ Text(title
                ,
                style: headlineText,
                textAlign: TextAlign.center,
              ),
            smallSpacing,
              Text(
               subtitle,
                textAlign: TextAlign.center,
                style: extraSmallText,
              ),],
    );
  }
}