
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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine grid layout based on available width
        int crossAxisCount;
        double childAspectRatio;
        
        if (constraints.maxWidth > 1200) {
          // Large desktop
          crossAxisCount = 5;
          childAspectRatio = 0.8;
        } else if (constraints.maxWidth > 900) {
          // Desktop
          crossAxisCount = 4;
          childAspectRatio = 0.75;
        } else if (constraints.maxWidth > 600) {
          // Tablet
          crossAxisCount = 3;
          childAspectRatio = 0.7;
        } else if (constraints.maxWidth > 450) {
          // Large phone
          crossAxisCount = 2;
          childAspectRatio = 0.7;
        } else {
          // Small phone
          crossAxisCount = 2;
          childAspectRatio = 0.8;
        }
        
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            final imageUrl = (products[index].images.isNotEmpty)
                ? products[index].images[0]
                : AppConstants.defaultImageUrl;
                
            return ProductCard(      
              products: products[index],
            );
          },
          itemCount: products.length,
        );
      },
    );
  }
}