import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/views/selling/banner_tab_screen.dart';
import 'package:fashion_admin_app/views/selling/categories/categories_tab_screen.dart';
import 'package:fashion_admin_app/views/selling/order_tab_screen.dart';
import 'package:fashion_admin_app/views/selling/product_tab_screens.dart';
import 'package:fashion_admin_app/views/selling/propmotion_tab_screen.dart';
import 'package:flutter/material.dart';

class SellingScreen extends StatelessWidget {
  const SellingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
     
      child: Scaffold(
        appBar: AppBar(backgroundColor: beigeColor,
          automaticallyImplyLeading: false,
          title: const Text('Selling ',style: screenText,),
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
