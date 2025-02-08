import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/model/products_model.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/views/cart/widgets/cart_item.dart';
import 'package:fashion_client_app/views/cart/widgets/order_summary.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart", style: appBarText),
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (value.cart.isEmpty) {
              return const Center(
                child: Text("No cart item"),
              );
            } else {
              return Column(
                children: [
                  Expanded(
  child:ListView.builder(
  itemCount: value.cart.length,
  itemBuilder: (context, index) {
    // Ensure the product list matches cart length
    if (index >= value.product.length) {
      return const SizedBox();
    }

    // Find the matching product for this cart item
    ProductModels matchingProduct = value.product.firstWhere(
      (p) => p.id == value.cart[index].productId,
      orElse: () => ProductModels(
        name: "Unknown Product",
        description: "No description available",
        images: [],
        oldPrice: 0,
        newPrice: 0,
        category: "Unknown",
        id: value.cart[index].productId, // Assign cart product ID
        maxQuantity: 0,
        colorVariants: [],
        sizeVariants: [],
      ), // Handle missing products
    );

    return CartItem(
      image: (matchingProduct.images.isNotEmpty) 
        ? matchingProduct.images[0] 
        : "assets/placeholder.jpg",
      name: matchingProduct.name,
      newPrice: matchingProduct.newPrice,
      size: value.cart[index].size,
      color: value.cart[index].color,
      cartId: value.cart[index].cartId,
      maxQuantity: matchingProduct.maxQuantity, 
      productId: matchingProduct.id,
    );
  },
),

),

                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: value.cart.length,
                  //     itemBuilder: (context, index) {
                  //       if (index >= value.product.length) {
                  //         return const SizedBox(); // Prevent index out of bounds
                  //       }

                  //       return CartItem(
                  //         image: (value.product[index].images.isNotEmpty)
                  //             ? value.product[index].images[0]
                  //             : "assets/placeholder.jpg",
                  //         name: value.product[index].name,
                  //         newPrice: value.product[index].newPrice,
                  //         size: value.cart[index].size,
                  //         color: value.cart[index].color,
                  //         cartId: value.cart[index].cartId,
                  //         maxQuantity:
                  //             value.product[index].maxQuantity, // Add this
                  //         productId: value.product[index].id,
                  //       );
                  //     },
                  //   ),
                  // ),
                  // CouponInput(),
                  OrderSummary(totalCost: value.totalCost.toString()),
                  CustomButton(text: "Place Order", onPressed: () {})
                ],
              );
            }
          }
        },
      ),
    );
  }
}



