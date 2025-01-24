
import 'package:fashion_client_app/views/home/widget/vertical_indicator.dart';
import 'package:fashion_client_app/views/home/widget/vertical_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fashion_client_app/provider/home_state_provider.dart';
import 'package:fashion_client_app/utils/demo_promo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController verticalController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            VerticalPageView(
              verticalController: verticalController,
              promoData: promoData,
            ),
            VerticalPageIndicator(
              verticalPageIndex:
                  context.watch<HomeStateProvider>().verticalPageIndex,
              totalPages: promoData.length,
            ),
          ],
        ),
      ),
    );
  }
}

