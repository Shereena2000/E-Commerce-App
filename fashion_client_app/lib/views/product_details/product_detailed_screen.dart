import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/model/products_model.dart';
import 'package:fashion_client_app/views/product_details/widget/color_variant_selector.dart';
import 'package:fashion_client_app/views/product_details/widget/product_info.dart';
import 'package:fashion_client_app/views/product_details/widget/size_varaint_selector.dart';
import 'package:fashion_client_app/widgets/app_bar_logo_title.dart';
import 'package:fashion_client_app/widgets/cart_button.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:fashion_client_app/widgets/product_view.dart';
import 'package:flutter/material.dart';

class ProductDetailedScreen extends StatelessWidget {
  final ProductModels product;
  const ProductDetailedScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double paddingSize = width - (width * 0.85);
    return Scaffold(
      appBar: AppBar(
        title: const AppBarLogoTitle(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: paddingSize - 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              liteSpacing,
              Align(
                alignment: Alignment.center,
                child: ProductView(
                  productImage: product.images,
                  width: width * 0.85,
                  height: height * 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductInfo(product: product),
                    const Text(
                      "Select size",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizeVariantSelector(product: product),
                    ColorVariantSelector(product: product)
                  ],
                ),
              ),
              liteSpacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(text: "BUY NOW", onPressed: () {}),
                  const CartButton(),
                ],
              ),
              largerSpacing
            ],
          ),
        ),
      ),
    );
  }
}
