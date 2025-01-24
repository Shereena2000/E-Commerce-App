import 'package:fashion_client_app/constants/dimension.dart';
import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  final List<String> productImage;
  final double width ;
  final double height ;
  const ProductView({super.key, required this.productImage,  this.width = 150,
    this.height = 200,});

  @override
  Widget build(BuildContext context) {
    return  Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              ClipRRect(
                borderRadius: radius5,
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(productImage[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Image.asset("assets/Favorite.png"),
              )
            ],
          );
  }
}