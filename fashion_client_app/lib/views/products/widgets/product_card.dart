import 'package:fashion_client_app/model/products_model.dart';
import 'package:fashion_client_app/provider/product_detail_provider.dart';
import 'package:fashion_client_app/views/product_details/product_detailed_screen.dart';
import 'package:fashion_client_app/views/products/widgets/product_sub_title.dart';
import 'package:fashion_client_app/widgets/product_image_container.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModels product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProductDetailProvider>().resetSelections();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailedScreen(
                      product: product,
                    )));
      },
      child: Column(
        children: [
          ProductImageContainer(productImage: product.images),
          ProductSubTitle(
            productName: product.name,
            newPrice: product.newPrice.toString(),
            // originalPrice: product.oldPrice.toString(),
          )
        ],
      ),
    );
  }
}
