import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/views/analytics/analytics_screen.dart';
import 'package:fashion_admin_app/views/dashboard/dashboard_screen.dart';
import 'package:fashion_admin_app/views/more/more_screen.dart';
import 'package:fashion_admin_app/views/selling/selling_screen.dart';
import 'package:flutter/material.dart';

class BottomNavWrapper extends StatefulWidget {
  const BottomNavWrapper({Key? key}) : super(key: key);

  @override
  _BottomNavWrapperState createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardScreen(),
    AnalyticsScreen(),
    SellingScreen(),
    MoreScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: colorTheme,
          index: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            Icon(Icons.dashboard),
            Icon(Icons.bar_chart),
            Icon(Icons.shopping_cart),
            Icon(Icons.menu),
          ],
        ));
  }
}
