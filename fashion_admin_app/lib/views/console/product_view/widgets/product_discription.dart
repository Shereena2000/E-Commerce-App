import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/models/product_models.dart';
import 'package:fashion_admin_app/utils/app_utils.dart';
import 'package:fashion_admin_app/views/console/product_view/widgets/selected_color_container.dart';
import 'package:fashion_admin_app/views/console/product_view/widgets/selected_size_container.dart.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

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
           ReCase( products.name).titleCase,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
             ' ₹${products.newPrice.toString()}',
              style: const TextStyle(color: greenColor, fontSize: 16),
            ),
            Text(
              '₹${products.oldPrice.toString()}',
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

