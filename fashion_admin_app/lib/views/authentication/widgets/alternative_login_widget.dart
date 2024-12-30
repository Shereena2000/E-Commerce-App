import 'package:fashion_admin_app/constants/colors.dart';
import 'package:flutter/material.dart';

class AlternativeLoginWidget extends StatelessWidget {
  final Color colour;
  final Color textColor;
  const AlternativeLoginWidget({
    super.key,
    this.colour = blackColor,
    this.textColor = blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: colour,
          ),
        ),
        Padding(
          padding:const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('or continue with', style: TextStyle(color: textColor)),
        ),
        Expanded(
          child: Divider(
            color: colour,
          ),
        ),
      ],
    );
  }
}
