import 'package:fashion_client_app/model/promo_model.dart';
import 'package:fashion_client_app/provider/home_state_provider.dart';
import 'package:fashion_client_app/views/home/widget/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerticalPageView extends StatelessWidget {
  final PageController verticalController;
  final PageController horizontalController;
  final Map<String, List<PromoModel>> groupedPromos;
  final List<String> categories;

  const VerticalPageView({
    required this.verticalController,
    required this.horizontalController,
    required this.groupedPromos,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: verticalController,
      itemCount: categories.length,
      onPageChanged: (index) {
        context.read<HomeStateProvider>().setVerticalPageIndex(index);
      },
      itemBuilder: (context, verticalIndex) {
        final String category = categories[verticalIndex];
        final List<PromoModel> promos = groupedPromos[category]!;

        return HomeView(
          promos: promos,
          horizontalController: horizontalController,
        );
      },
    );
  }
}