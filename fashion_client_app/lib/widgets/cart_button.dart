import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/model/cart_model.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/widgets/custom_snack_bar.dart';
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
        // Validate both size and color selections
        if (selectedSize == null || selectedSize!.isEmpty || selectedColor == null || selectedColor!.isEmpty) {
          // Show error message if either size or color is not selected
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: CustomSnackBar(
                errorMessage: "Please select both size and color",
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
        } else {
          String cartId = "${productId}_${selectedSize}_${selectedColor}";
          // Add to cart only if both size and color are selected
          Provider.of<CartProvider>(context, listen: false).addToCart(
            CartModel(
              productId: productId,
              quantity: 1,
              size: selectedSize!,
              color: selectedColor!,
              cartId: cartId,
            ),
          );

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Added to cart"),
              behavior: SnackBarBehavior.floating,
            ),
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