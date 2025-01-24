import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/models/product_models.dart';
import 'package:fashion_admin_app/views/console/product_view/widgets/product_image.dart';
import 'package:fashion_admin_app/views/console/product_view/widgets/product_discription.dart';
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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImage(width: width, products: widget.products),
            TopRoundContainer(
              color: whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ProductDiscription(products: widget.products,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

