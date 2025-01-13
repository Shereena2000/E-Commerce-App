import 'package:fashion_client_app/views/cart/cart_screen.dart';
import 'package:fashion_client_app/views/categories/categories_screen.dart';
import 'package:fashion_client_app/views/home/home_screen.dart';
import 'package:fashion_client_app/views/more/more_screen.dart';
import 'package:fashion_client_app/views/search/search_screen.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    CategoriesScreen(),
    SearchScreen(),
    CartScreen(),
    MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        shadowColor: Colors.grey,
        indicatorColor: Colors.grey,
        backgroundColor: Colors.white,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.grid_view), label: "Categories"),
          NavigationDestination(icon: Icon(Icons.search), label: "Search"),
          NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
          NavigationDestination(
              icon: Icon(Icons.person_outlined), label: "Profile"),
        ],
      ),
    );
  }
}
