

import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/models/product_models.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({
    super.key,
    required this.width,
    required this.products,
    this.imageHeight,
  });

  final double width;
  final ProductModels products;
  final double? imageHeight; // Optional height parameter for custom sizing

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  int selectedImage = 0;
  
  @override
  Widget build(BuildContext context) {
    // Adjust layout based on screen width
    final isDesktop = MediaQuery.of(context).size.width > 1024;
    final isTablet = MediaQuery.of(context).size.width > 600 && MediaQuery.of(context).size.width <= 1024;
    
    return Column(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.imageHeight,
          child: AspectRatio(
            aspectRatio: isDesktop ? 1 : (isTablet ? 1.2 : 1),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/placeholder.jpg",
              image: widget.products.images[selectedImage],
              fit: BoxFit.contain,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/placeholder.jpg",
                  fit: BoxFit.contain,
                );
              }
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.products.images.length,
            itemBuilder: (context, index) => buildSmallPreview(index),
          ),
        )
      ],
    );
  }

  Widget buildSmallPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(2),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: beigeColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedImage == index ? blackColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/placeholder.jpg",
            image: widget.products.images[index],
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/placeholder.jpg",
                fit: BoxFit.cover,
              );
            }
          ),
        ),
      ),
    );
  }
}