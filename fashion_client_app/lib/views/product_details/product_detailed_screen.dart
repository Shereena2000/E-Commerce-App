import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/products_model.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/provider/product_detail_provider.dart';
import 'package:fashion_client_app/views/product_details/widget/color_variant_selector.dart';
import 'package:fashion_client_app/views/product_details/widget/product_info.dart';
import 'package:fashion_client_app/views/product_details/widget/size_varaint_selector.dart';
import 'package:fashion_client_app/widgets/cart_button.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:fashion_client_app/widgets/custom_main_app_bar.dart';
import 'package:fashion_client_app/widgets/product_image_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailedScreen extends StatelessWidget {
  final ProductModels product;
  const ProductDetailedScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double paddingSize = width - (width * 0.85);
    return Scaffold(
      appBar: const CustomMainAppBar(),
      body: Consumer<ProductDetailProvider>(
        builder: (context, productDetailprovider, child) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: paddingSize - 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  liteSpacing,
                  Align(
                    alignment: Alignment.center,
                    child: ProductImageContainer(
                      productId: product.id,
                      showCarousel: true,
                      productImage: product.images,
                      width: width * 0.85,
                      height: height * 0.5,
                      favoriteIconSize: 30,
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
                      CustomButton(
                        text: "BUY NOW",
                        onPressed: () async{
                          if (product.maxQuantity == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Product is out of stock"),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            return;
                          }

                          if (productDetailprovider.selectedSize == null ||
                              productDetailprovider.selectedSize!.isEmpty ||
                              productDetailprovider.selectedColor == null ||
                              productDetailprovider.selectedColor!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Please select both size and color"),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else {
                         await   DbService().emptyCard();
                      await      Provider.of<CartProvider>(context, listen: false)
                                .buyProduct(
                                    context: context,
                                    selectedSize:
                                        productDetailprovider.selectedSize!,
                                    selectedColor:
                                        productDetailprovider.selectedColor!,
                                    productId: product.id,
                                    isCart: false);
                            Navigator.pushNamed(context, '/checkout');
                          }
                        },
                      ),
                      CartButton(
                        productId: product.id,
                        selectedSize: productDetailprovider.selectedSize,
                        selectedColor: productDetailprovider.selectedColor,
                        maxQuantity: product.maxQuantity,
                      ),
                    ],
                  ),
                  largerSpacing
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
