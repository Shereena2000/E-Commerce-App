import 'package:fashion_client_app/constants/dimension.dart';
import 'package:fashion_client_app/provider/product_detail_provider.dart';
import 'package:fashion_client_app/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductImageContainer extends StatelessWidget {
  final List<String> productImage;
  final String productId;
  final double width;
  final double height;
  final bool showCarousel;
  final double? favoriteIconSize;
  const ProductImageContainer({
    super.key,
    required this.productImage,
    this.width = 150,
    this.showCarousel = false,
    this.height = 200,
    required this.productId,
    this.favoriteIconSize ,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailProvider>(
      builder: (context, provider, child) {
        return Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            ClipRRect(
              borderRadius: radius5,
              child: SizedBox(
                width: width,
                height: height,
                child: showCarousel
                    ? PageView.builder(
                        itemCount: productImage.length,
                        onPageChanged: (index) {
                          provider.setCurrentPage(index); // Update current page
                        },
                        itemBuilder: (context, index) {
                          return Image.network(
                            productImage[index],
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.network(
                        productImage[0], // Show only the first image
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Positioned(
              right: -4,
              top: -3,
              child: FavoriteButton(
                productId: productId,
                size: favoriteIconSize,
              ),
            ),
            if (showCarousel)
              Positioned(
                bottom: 10,
                right: width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    productImage.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: provider.currentPage == index
                            ? Colors.white // Highlighted dot
                            : Colors.grey.withOpacity(0.5), // Unhighlighted dot
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
