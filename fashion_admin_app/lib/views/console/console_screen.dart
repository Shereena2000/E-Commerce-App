import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/views/console/banners/banner_tab_screen.dart';
import 'package:fashion_admin_app/views/console/categories/categories_tab_screen.dart';
import 'package:fashion_admin_app/views/console/ordres/order_tab_screen.dart';
import 'package:fashion_admin_app/views/console/products/product_tab_screens.dart';
import 'package:fashion_admin_app/views/console/promotions/propmotion_tab_screen.dart';
import 'package:flutter/material.dart';

class ConsoleScreen extends StatelessWidget {
  const ConsoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
     
      child: Scaffold(
        appBar: AppBar(backgroundColor: beigeColor,
          automaticallyImplyLeading: false,
          title: const Text('Console ',style: screenText,),
          bottom: const TabBar(isScrollable: true,
          labelStyle: normalText,
            tabs: [ 
              Tab(text: 'Orders',),
             Tab(text: 'Products'),
              Tab(text: 'Categories'),
              Tab(text: 'Promos'),
              Tab(text: 'Banners'),
            
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrderTabScreen(),
            ProductTabScreens(),
           CategoriesTabScreen(),
            PropmotionTabScreen(),
            BannerTabScreen(),
           
          ],
        ),
      ),
    );
  }
}
