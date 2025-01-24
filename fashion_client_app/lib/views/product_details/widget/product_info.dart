import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/model/products_model.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
   final ProductModels product;
  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column( crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Text(
                      product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    liteSpacing,
                    Text(
                      product.newPrice.toString(),
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    liteSpacing,
                    Text(
                      product.description,
                      style:
                          const TextStyle(fontSize: 15, color: Colors.blueGrey),
                    ),
                    liteSpacing,
    ],);
  }
}