import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/providers/bottom_nav_provider.dart';
import 'package:fashion_admin_app/views/analytics/analytics_screen.dart';
import 'package:fashion_admin_app/views/dashboard/dashboard_screen.dart';
import 'package:fashion_admin_app/views/more/more_screen.dart';
import 'package:fashion_admin_app/views/console/console_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavWrapper extends StatelessWidget {
  const BottomNavWrapper({Key? key}) : super(key: key);

  final List<Widget> _pages = const [
    DashboardScreen(),
    AnalyticsScreen(),
    ConsoleScreen(),
    MoreScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider=Provider.of<BottomNavProvider>(context);
    return Scaffold(
        body: _pages[bottomNavProvider.currentindex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: colorTheme,
          index: bottomNavProvider.currentindex,
          onTap: (index) {
            bottomNavProvider.updateIndex(index);
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
