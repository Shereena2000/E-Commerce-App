import 'package:fashion_client_app/model/products_model.dart';
import 'package:fashion_client_app/provider/product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SizeVariantSelector extends StatelessWidget {
  const SizeVariantSelector({
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
          product.sizeVariants.length,
          (index) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                context
                    .read<ProductDetailProvider>()
                    .selectSize(product.sizeVariants[index]);
              },
              child: Ink(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: context
                              .watch<ProductDetailProvider>()
                              .selectedSize ==
                          product.sizeVariants[index]
                      ? Border.all()
                      : const Border(),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    product.sizeVariants[index],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

