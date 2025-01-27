import 'package:fashion_admin_app/constants/app_constants.dart';
import 'package:fashion_admin_app/models/product_models.dart';
import 'package:fashion_admin_app/views/console/products/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
  });

  final List<ProductModels> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        (products[index].images.isNotEmpty)
            ? products[index].images[0]
            : AppConstants.defaultImageUrl;
        return ProductCard(
        
          products: products[index],
        );
      },
      itemCount: products.length,
    );
  }
}
