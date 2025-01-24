import 'package:fashion_client_app/model/promo_model.dart';
import 'package:fashion_client_app/provider/home_state_provider.dart';
import 'package:fashion_client_app/views/home/widget/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerticalPageView extends StatelessWidget {
  final PageController verticalController;
  final List<PromoModel> promoData;

  const VerticalPageView({
    required this.verticalController,
    required this.promoData,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: verticalController,
      itemCount: promoData.length,
      onPageChanged: (index) {
        context.read<HomeStateProvider>().setVerticalPageIndex(index);
      },
      itemBuilder: (context, index) {
        return HomeView(promo: promoData[index]);
      },
    );
  }
}


