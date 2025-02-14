import 'package:fashion_client_app/model/promo_model.dart';
import 'package:fashion_client_app/views/home/widget/horizontal_page_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final List<PromoModel> promos;
  final PageController horizontalController;

  const HomeView({
    required this.promos,
    required this.horizontalController,
  });

  @override
  Widget build(BuildContext context) {
  
    return Stack(
      children: [
        HorizontalPageView(
          promos: promos,
          horizontalController: horizontalController,
        ),
        // Add additional UI elements here if needed
      ],
    );
  }
}