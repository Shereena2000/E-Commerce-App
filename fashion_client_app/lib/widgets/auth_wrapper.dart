import 'package:fashion_client_app/provider/user_provider.dart';
import 'package:fashion_client_app/views/authentication/welcome_screen.dart';
import 'package:fashion_client_app/views/splash/splash_screen.dart';
import 'package:fashion_client_app/widgets/custom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading screen while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        // User is logged in
        if (snapshot.hasData) {
          // Initialize user-dependent providers
          context.read<UserProvider>();
          return const MainAppWrapper();
        }

        // User is not logged in
        return const AuthFlowWrapper();
      },
    );
  }
}

class MainAppWrapper extends StatelessWidget {
  const MainAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomNavBar(); // Your main app screen
  }
}

class AuthFlowWrapper extends StatelessWidget {
  const AuthFlowWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeScreen(); // Your initial auth screen
  }
}