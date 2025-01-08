import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/firebase_options.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/views/authentication/forgot_screen.dart';
import 'package:fashion_admin_app/views/authentication/login_screen.dart';
import 'package:fashion_admin_app/views/authentication/sign_up_screen.dart';
import 'package:fashion_admin_app/views/authentication/welcome_screen.dart';
import 'package:fashion_admin_app/views/splash/splash_screen.dart';
import 'package:fashion_admin_app/widgets/bottom_bar_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>AdminProviders(),builder: (context, child) => 
       MaterialApp(
        title: 'Fashion Admin App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: beigeColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: colorTheme,
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/signUp': (context) => const SignUp(),
          '/forgot': (context) => const ForgotScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/home': (context) => const BottomNavWrapper(),
        },
      ),
    );
  }
}
