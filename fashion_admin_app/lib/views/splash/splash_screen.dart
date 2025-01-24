import 'package:fashion_admin_app/controllers/auth_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _navigateToWelcomeScreen();
  }

  Future<void> _navigateToWelcomeScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      AuthService().isLoggedIn().then((value) {
        if (value) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/welcome');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
