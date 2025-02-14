import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/model/promo_model.dart';
import 'package:fashion_client_app/provider/home_state_provider.dart';
import 'package:fashion_client_app/views/home/widget/background_image.dart';
import 'package:fashion_client_app/views/home/widget/logo.dart';
import 'package:fashion_client_app/views/home/widget/sub_title.dart';
import 'package:fashion_client_app/views/home/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalPageView extends StatelessWidget {
  final List<PromoModel> promos;
  final PageController horizontalController;

  const HorizontalPageView({
    required this.promos,
    required this.horizontalController,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: horizontalController,
      itemCount: promos.length,
      onPageChanged: (index) {
        context.read<HomeStateProvider>().setHorizontalPageIndex(index);
      },
      itemBuilder: (context, horizontalIndex) {
        final PromoModel promo = promos[horizontalIndex];
        
        return Stack(
          children: [
            BackgroundImage(imageUrl: promo.imageUrl),
            Logo(),
          const  ScrollArrow(),
            CustomTitle(
              title: promo.title,
              bottom: 180,
              right: 70,
            ),
            Subtitle(
              subtitle: promo.subTitle,
              bottom: 150,
              right: 100,
            ),
          ],
        );
      },
    );
  }
}

class ScrollArrow extends StatelessWidget {
  const ScrollArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: MediaQuery.of(context).size.height / 2 - 40,
      child:const Icon(
        Icons.chevron_right,
        color: whiteColor,
        size: 40,
      ),
    );
  }
}
