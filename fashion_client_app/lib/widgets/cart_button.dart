import 'package:fashion_client_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add your button action here
        print("Button pressed");
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
