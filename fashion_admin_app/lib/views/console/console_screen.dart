
import 'package:flutter/material.dart';
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/views/console/categories/screens/categories_tab_screen.dart';
import 'package:fashion_admin_app/views/console/ordres/screens/order_tab_screen.dart';
import 'package:fashion_admin_app/views/console/products/screens/product_tab_screens.dart';
import 'package:fashion_admin_app/views/console/promotions/propmotion_screen.dart';

class ConsoleScreen extends StatelessWidget {
  const ConsoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: beigeColor,
          automaticallyImplyLeading: false,
          title: const Text(
            'Console',
            style: screenText,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Center the TabBar for web or wider screens
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: const TabBar(
                        isScrollable: false, // Keep tabs centered
                        labelStyle: normalText,
                        tabs: [
                          Tab(text: 'Products'),
                          Tab(text: 'Categories'),
                          Tab(text: 'Orders'),
                          Tab(text: 'Promos'),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Default behavior for smaller screens
                  return const TabBar(
                    isScrollable: true, // Allow scrolling on small screens
                    labelStyle: normalText,
                    tabs: [
                      Tab(text: 'Products'),
                      Tab(text: 'Categories'),
                      Tab(text: 'Orders'),
                      Tab(text: 'Promos'),
                    ],
                  );
                }
              },
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ProductTabScreens(),
            CategoriesTabScreen(),
            OrderTabScreen(),
            PromotionScreen(),
          ],
        ),
      ),
    );
  }
}
