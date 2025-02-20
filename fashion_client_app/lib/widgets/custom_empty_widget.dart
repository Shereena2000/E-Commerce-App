import 'package:fashion_client_app/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomEmptyWidget extends StatelessWidget {
  final String text;
  final String asset;
  const CustomEmptyWidget({
    super.key, required this.text, required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Lottie.asset(asset),
          ),
        moderateSpacing,
        Text(
            text,
            style:const TextStyle(fontWeight: FontWeight.bold)
          )
        ],
      ),
    );
  }
}
