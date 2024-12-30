import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  AppBar(automaticallyImplyLeading: false,backgroundColor: beigeColor,
          title:const Text(
        'Analytics',
        style: screenText,
      )),
    );
  }
}
