import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: MediaQuery.of(context).size.width / 2 - 70,
      top: 10,
      child: Image.asset("assets/logo.png"),
    );
  }
}
