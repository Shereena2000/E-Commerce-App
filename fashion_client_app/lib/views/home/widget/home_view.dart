import 'package:fashion_client_app/model/promo_model.dart';
import 'package:fashion_client_app/views/home/widget/horizontal_page_indicator.dart';
import 'package:fashion_client_app/views/home/widget/horizontal_page_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final PromoModel promo;

  const HomeView({required this.promo});

  @override
  Widget build(BuildContext context) {
    final PageController horizontalController = PageController();

    return Stack(
      children: [
        HorizontalPageView(
          promo: promo,
          horizontalController: horizontalController,
        ),
        HorizontalPageIndicator(
          horizontalController: horizontalController,
          pageCount: promo.imageUrls.length,
        ),
      ],
    );
  }
}
