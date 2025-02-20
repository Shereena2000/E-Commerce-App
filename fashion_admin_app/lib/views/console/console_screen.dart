import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/views/console/categories/screens/categories_tab_screen.dart';
import 'package:fashion_admin_app/views/console/ordres/screens/order_tab_screen.dart';
import 'package:fashion_admin_app/views/console/products/screens/product_tab_screens.dart';
import 'package:fashion_admin_app/views/console/promotions/propmotion_screen.dart';

import 'package:flutter/material.dart';

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
            'Console ',
            style: screenText,
          ),
          bottom: const TabBar(
            isScrollable: true,
            labelStyle: normalText,
            tabs: [
              Tab(text: 'Products'),
              Tab(text: 'Categories'),
              Tab(
                text: 'Orders',
              ),
              Tab(text: 'Promos'),
             
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProductTabScreens(),
            CategoriesTabScreen(),
            OrderTabScreen(),
            PropmotionScreen(),
           
          ],
        ),
      ),
    );
  }
}
