import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/dashboard');
    });
    return Scaffold(body: Center(child: Image.asset('assets/logo.png')),);
  }
}