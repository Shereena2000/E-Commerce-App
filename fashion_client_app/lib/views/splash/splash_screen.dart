import 'package:fashion_client_app/controllers/auth_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToWelcomeScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( child: Image.asset('assets/logo.png'),),
    );
  }
  
  Future<void>_navigateToWelcomeScreen() async{
     await Future.delayed(const Duration(seconds: 2));
     if (mounted) {
      AuthService().isLoggedIn().then((value) {
        if (value) {
        Navigator.pushReplacementNamed(context, '/navBar');}
      else {
          Navigator.pushReplacementNamed(context, '/welcome');
        }
      });
  }
}
}