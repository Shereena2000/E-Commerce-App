import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/models/product_models.dart';
import 'package:fashion_admin_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class ProductDiscription extends StatelessWidget {
  final ProductModels products;
  const ProductDiscription({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            products.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              products.newPrice.toString(),
              style: const TextStyle(color: greenColor, fontSize: 16),
            ),
            Text(
              products.oldPrice.toString(),
              style: const TextStyle(
                  color: greenColor,
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.green),
            )
          ],
        ),
        smallSpacing,
        Text(
          products.description,
          maxLines: 3,
          style: const TextStyle(color: Colors.blueGrey, fontSize: 16),
        ),
        Row(
          children: [
            ...List.generate(products.sizeVariants.length, (index) {
              final size = products.sizeVariants[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectedSizeContainer(size: size),
              );
            })
          ],
        ),
        Row(
          children: [
            ...List.generate(products.colorVariants.length, (index) {
              final colorName = products.colorVariants[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectedColorContainer(color: colorMap[colorName]!),
              );
            })
          ],
        ),
      ],
    );
  }
}

class SelectedSizeContainer extends StatelessWidget {
  final String size;
  const SelectedSizeContainer({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: blackColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        size,
        style: const TextStyle(color: blackColor),
      ),
    );
  }
}

class SelectedColorContainer extends StatelessWidget {
  final Color color;
  const SelectedColorContainer({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
    );
  }
}
