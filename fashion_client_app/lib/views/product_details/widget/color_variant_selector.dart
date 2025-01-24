import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/model/products_model.dart';
import 'package:fashion_client_app/provider/product_detail_provider.dart';
import 'package:fashion_client_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorVariantSelector extends StatelessWidget {
  const ColorVariantSelector({
    super.key,
    required this.product,
  });

  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          product.colorVariants.length,
          (index) {
            final color =
                colorMap[product.colorVariants[index]] ??
                    Colors.black;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  context
                      .read<ProductDetailProvider>()
                      .selectColor(product.colorVariants[index]);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    shape: BoxShape.circle,
                    border: context
                                .watch<ProductDetailProvider>()
                                .selectedColor ==
                            product.colorVariants[index]
                        ? Border.all(color: whiteColor, width: 3)
                        : const Border(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
