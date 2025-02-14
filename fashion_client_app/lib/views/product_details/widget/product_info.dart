import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class ProductInfo extends StatelessWidget {
  final ProductModels product;
  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name.titleCase,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        liteSpacing,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹${product.newPrice.toString()}',
              style: const TextStyle(
                  color: greenColor, fontWeight: FontWeight.bold),
            ),
            Text(
              '₹${product.oldPrice.toString()}',
              style: const TextStyle(
                  color: greenColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: greenColor),
            ),
          ],
        ),
        liteSpacing,
        product.maxQuantity == 0
            ? const Text(
                "Out of Stock",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.red),
              )
            : Text(
                "Only ${product.maxQuantity} left in stock",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey),
              ),
        liteSpacing,
        Text(
          product.description,
          style: const TextStyle(fontSize: 15, color: Colors.blueGrey),
        ),
        liteSpacing,
      ],
    );
  }
}
