import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/views/analytics/analytics_screen.dart';
import 'package:fashion_admin_app/views/dashboard/dashboard_screen.dart';
import 'package:fashion_admin_app/views/more/more_screen.dart';
import 'package:fashion_admin_app/views/selling/selling_screen.dart';
import 'package:fashion_admin_app/views/splash/splash_screen.dart';
import 'package:fashion_admin_app/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: beigeColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: colorTheme,
        ),
        useMaterial3: true,
      ),
       initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/dashboard': (context) => CurvedNavigationbar(child: const DashboardScreen(), initialIndex: 0),
        '/analytics': (context) =>  CurvedNavigationbar(child: const AnalyticsScreen(), initialIndex: 1),
        '/selling': (context) =>  CurvedNavigationbar(child: const SellingScreen(), initialIndex: 2),
        '/more': (context) =>  CurvedNavigationbar(child: const MoreScreen(), initialIndex: 3),
      },
    );
  }
}
