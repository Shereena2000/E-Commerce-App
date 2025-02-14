import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/firebase_options.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/providers/auth_state_provider.dart';
import 'package:fashion_admin_app/providers/bottom_nav_provider.dart';
import 'package:fashion_admin_app/providers/category_provider.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';
import 'package:fashion_admin_app/providers/promo_provider.dart';
import 'package:fashion_admin_app/providers/user_provider.dart';
import 'package:fashion_admin_app/views/authentication/forgot_screen.dart';
import 'package:fashion_admin_app/views/authentication/login_screen.dart';
import 'package:fashion_admin_app/views/authentication/sign_up_screen.dart';
import 'package:fashion_admin_app/views/authentication/welcome_screen.dart';
import 'package:fashion_admin_app/views/console/coupons/coupons_screens.dart';
import 'package:fashion_admin_app/views/splash/splash_screen.dart';
import 'package:fashion_admin_app/widgets/bottom_bar_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'views/console/ordres/view_order_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AdminProviders()),
        ChangeNotifierProvider(create: (context) => AuthStateProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PromoProvider()),
      ],
      child: MaterialApp(
        title: 'Fashion Admin App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: beigeColor),
          scaffoldBackgroundColor: beigeColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: colorTheme,
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/signUp': (context) => SignUpScreen(),
          '/forgot': (context) => const ForgotScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/home': (context) => BottomNavWrapper(),
          '/coupon': (context) => const CouponsScreens(),
          '/vieworder': (context) => const ViewOrderScreen()
        },
      ),
    );
  }
}
