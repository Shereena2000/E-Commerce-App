import 'package:flutter/material.dart';

class AppBarLogoTitle extends StatelessWidget {
  const AppBarLogoTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset(
                "assets/logo.png",
                height: 50, 
                fit: BoxFit.contain,
              ),
            ),
          ],
        );
  }
}