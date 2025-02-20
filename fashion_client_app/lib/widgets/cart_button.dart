
import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartButton extends StatelessWidget {
  final String productId;
  final String? selectedSize;
  final String? selectedColor;

  const CartButton({
    super.key,
    required this.productId,
    required this.selectedSize,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (selectedSize == null || selectedSize!.isEmpty || selectedColor == null || selectedColor!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please select both size and color"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          Provider.of<CartProvider>(context, listen: false).buyProduct(
            context: context,
            selectedSize: selectedSize!,
            selectedColor: selectedColor!,
            productId: productId,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(12),
        backgroundColor: whiteColor,
        side: const BorderSide(color: blackColor, width: 1),
        elevation: 2,
      ),
      child: const Icon(Icons.shopping_cart, color: Colors.black),
    );
  }
}