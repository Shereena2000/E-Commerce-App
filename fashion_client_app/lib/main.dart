import 'package:fashion_client_app/views.dart/authentication/signin_screen.dart';
import 'package:fashion_client_app/views.dart/authentication/welcome_screen.dart';
import 'package:fashion_client_app/views.dart/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion',
      theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
          textTheme:const TextTheme(
            headlineLarge: TextStyle(color: Colors.black),
            headlineMedium: TextStyle(color: Colors.black),
            headlineSmall: TextStyle(color: Colors.black),
          ),iconTheme: const IconThemeData(color: Colors.black),

          ),
     
     initialRoute: '/',
     routes: {
      '/':(context)=>SplashScreen(),
      '/signin':(context)=> const SigninScreen(),
       '/signUp':(context)=>const SigninScreen(),
       '/welcome':(context)=> const WelcomeScreen()
     },
    );
  }
}
