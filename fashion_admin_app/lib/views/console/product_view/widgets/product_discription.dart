

import 'package:fashion_admin_app/constants/colors.dart';

import 'package:fashion_admin_app/models/product_models.dart';
import 'package:fashion_admin_app/utils/app_utils.dart';
import 'package:fashion_admin_app/views/console/product_view/widgets/selected_color_container.dart';
import 'package:fashion_admin_app/views/console/product_view/widgets/selected_size_container.dart';


import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class ProductDescription extends StatelessWidget {
  final ProductModels products;
  const ProductDescription({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 1024;
    final isTablet = width > 600 && width <= 1024;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isDesktop) Center(
          child: Text(
            ReCase(products.name).titleCase,
            style: TextStyle(
              fontSize: isTablet ? 22 : 18, 
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (isDesktop) Text(
          ReCase(products.name).titleCase,
          style: const TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ' ₹${products.newPrice.toString()}',
              style: TextStyle(
                color: greenColor, 
                fontSize: isDesktop ? 20 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              '₹${products.oldPrice.toString()}',
              style: TextStyle(
                color: greenColor,
                fontSize: isDesktop ? 18 : 14,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.green,
              ),
            ),
            if (isDesktop) Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: _buildDiscountBadge(products),
              ),
            ),
          ],
        ),
        if (!isDesktop) _buildDiscountBadge(products),
        const SizedBox(height: 20),
        Text(
          "Description",
          style: TextStyle(
            fontSize: isDesktop ? 18 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          products.description,
          style: TextStyle(
            color: Colors.blueGrey, 
            fontSize: isDesktop ? 16 : 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Available Sizes",
          style: TextStyle(
            fontSize: isDesktop ? 18 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(products.sizeVariants.length, (index) {
                final size = products.sizeVariants[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child:  SelectedSizeContainer(
                    size: size,
                    isDesktop: isDesktop,
                  ),
                );
              })
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Available Colors",
          style: TextStyle(
            fontSize: isDesktop ? 18 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(products.colorVariants.length, (index) {
                final colorName = products.colorVariants[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SelectedColorContainer(
                    color: colorMap[colorName]!,
                    size: isDesktop ? 40 : 30,
                  ),
                );
              })
            ],
          ),
        ),
       
      ],
    );
  }
  
  Widget _buildDiscountBadge(ProductModels product) {
    final discount = ((product.oldPrice - product.newPrice) / product.oldPrice * 100).round();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        "$discount% OFF",
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  
}