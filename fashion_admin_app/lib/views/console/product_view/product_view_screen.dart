
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/models/product_models.dart';
import 'package:fashion_admin_app/views/console/product_view/widgets/product_discription.dart';
import 'package:fashion_admin_app/views/console/product_view/widgets/product_image.dart';

import 'package:fashion_admin_app/widgets/top_round_container.dart';
import 'package:flutter/material.dart';

class ProductViewScreen extends StatefulWidget {
  final ProductModels products;
  const ProductViewScreen({super.key, required this.products});

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isDesktop = width > 1024;
    final isTablet = width > 600 && width <= 1024;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        centerTitle: true,
      ),
      body: isDesktop
          ? _buildDesktopLayout(context, width)
          : _buildMobileTabletLayout(context, width, isTablet),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left part - Product Image (40% of screen)
        SizedBox(
          width: width * 0.4,
          child: ProductImage(
            width: width * 0.4,
            products: widget.products,
          ),
        ),
        // Right part - Product Description (60% of screen)
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: ProductDescription(products: widget.products),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileTabletLayout(BuildContext context, double width, bool isTablet) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image takes full width on mobile, 70% on tablet
          ProductImage(
            width: width,
            products: widget.products, 
            imageHeight: isTablet ? width * 0.7 : null,
          ),
          TopRoundContainer(
            color: whiteColor,
            child: Padding(
              padding: EdgeInsets.all(isTablet ? 30.0 : 20.0),
              child: ProductDescription(products: widget.products),
            ),
          ),
        ],
      ),
    );
  }
}