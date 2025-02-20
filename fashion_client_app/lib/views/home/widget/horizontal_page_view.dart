
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_client_app/model/promo_model.dart';
import 'package:fashion_client_app/provider/home_state_provider.dart';
import 'package:fashion_client_app/views/home/widget/background_image.dart';
import 'package:fashion_client_app/views/home/widget/logo.dart';
import 'package:fashion_client_app/views/home/widget/sub_title.dart';
import 'package:fashion_client_app/views/home/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalCarousel extends StatelessWidget {
  final List<PromoModel> promos;

  const HorizontalCarousel({required this.promos});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        viewportFraction: 1.0, 
        onPageChanged: (index, reason) {
          context.read<HomeStateProvider>().setHorizontalPageIndex(index);
        },
      ),
      itemCount: promos.length,
      itemBuilder: (context, index, realIndex) {
        final PromoModel promo = promos[index];

        return GestureDetector(
          onTap: (){  Navigator.pushNamed(context, '/categories');},
          child: Stack(
            children: [
            BackgroundImage(imageUrl: promo.imageUrl),
              Logo(),
                 
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
          ),
        );
      },
    );
  }
}

