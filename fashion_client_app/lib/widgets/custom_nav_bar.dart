import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/views/cart/cart_screen.dart';
import 'package:fashion_client_app/views/categories/categories_screen.dart';
import 'package:fashion_client_app/views/home/home_screen.dart';
import 'package:fashion_client_app/views/more/more_screen.dart';
import 'package:fashion_client_app/views/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const SearchScreen(),
    const CartScreen(),
    const MoreScreen(),
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
        destinations: [
          const NavigationDestination(
              icon: Icon(Icons.home_outlined), label: "Home"),
          const NavigationDestination(
              icon: Icon(Icons.grid_view), label: "Categories"),
          const NavigationDestination(
              icon: Icon(Icons.search), label: "Search"),
          NavigationDestination(
            icon: Consumer<CartProvider>(
              builder: (context, value, child) {
                return value.cart.isNotEmpty
                    ? Badge(backgroundColor: blackColor,
                        label: Text(value.cart.length.toString()),
                        child: Icon(Icons.shopping_cart_outlined),
                      )
                    : const Icon(Icons.shopping_cart_outlined);
              },
            ),
            label: "Cart",
          ),
          const NavigationDestination(
              icon: Icon(Icons.person_outlined), label: "Profile"),
        ],
      ),
    );
  }
}
