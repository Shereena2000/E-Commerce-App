import 'package:fashion_admin_app/constants/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fashion_admin_app/views/analytics/analytics_screen.dart';
import 'package:fashion_admin_app/views/dashboard/dashboard_screen.dart';
import 'package:fashion_admin_app/views/more/more_screen.dart';
import 'package:fashion_admin_app/views/selling/selling_screen.dart';
import 'package:flutter/material.dart';

class CurvedNavigationbar extends StatefulWidget {
  final int initialIndex;
  final Widget child;
  const CurvedNavigationbar({super.key, required this.initialIndex, required this.child});

  @override
  State<CurvedNavigationbar> createState() => _CurvedNavigationbarState();
}

class _CurvedNavigationbarState extends State<CurvedNavigationbar> {
  int _selectedIndex = 0;  // Keep track of the selected index

    final List<Widget> _screens = [
    DashboardScreen(),
    AnalyticsScreen(),
    SellingScreen(),
    MoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Set the initial screen index if provided
  }

  // Method to handle navigation bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],  // Display the selected screen
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: colorTheme,color: beigeColor,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        index: _selectedIndex,  // Set selected index
        items: const [
          Icon(Icons.home,),
          Icon(Icons.bar_chart),
          Icon(Icons.shopping_cart),
          Icon(Icons.menu),
        ],
        onTap: _onItemTapped,  // Handle item tap
      ),
    );
  }
}