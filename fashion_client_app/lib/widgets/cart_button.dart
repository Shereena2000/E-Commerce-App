import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/model/cart_model.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartButton extends StatelessWidget {
  final String productId;
  const CartButton({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add your button action here
        Provider.of<CartProvider>(context, listen: false)
            .addToCart(CartModel(productId: productId, quantity: 1));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Added to cart")));
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(12),
        backgroundColor: whiteColor,
        side: BorderSide(color: blackColor, width: 1),
        elevation: 2,
      ),
      child: const Icon(Icons.shopping_cart, color: Colors.black),
    );
  }
}
