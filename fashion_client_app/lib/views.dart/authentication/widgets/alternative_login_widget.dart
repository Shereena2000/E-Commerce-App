import 'package:fashion_client_app/constants/colors.dart';
import 'package:flutter/material.dart';

class AlternativeLoginWidget extends StatelessWidget {
  final Color colour;
  final Color textColor;
  final bool whiteSocialButton;
  const AlternativeLoginWidget({
    super.key,
    this.colour = blackColor,
    this.textColor = blackColor,
    this.whiteSocialButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: Divider(
              color: colour,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('or continue with', style: TextStyle(color: textColor)),
          ),
          Expanded(
            child: Divider(
              color: colour,
            ),
          ),
        ],
      ),
    ]);
  }
}
