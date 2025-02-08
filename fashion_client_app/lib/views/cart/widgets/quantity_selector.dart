import 'package:fashion_client_app/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';

class QuantitySelector extends StatelessWidget {
  final String cartId;
  final int quantity;
  final int maxQuantity;

  const QuantitySelector({
    Key? key,
    required this.cartId,
    required this.quantity,
    required this.maxQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: quantity > 1 
              ? () {
                  context.read<CartProvider>().decreaseCount(cartId);
                }
              : null,
            icon: const Icon(
              Icons.remove,
              size: 15,
            ),
          ),
          Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          IconButton(
            onPressed: quantity < maxQuantity 
              ? () {
                  context.read<CartProvider>().addToCart(
                    CartModel(
                      cartId: cartId,
                      productId: cartId,
                      size: "",  // These will be preserved as they're already in Firestore
                      color: "", // These will be preserved as they're already in Firestore
                      quantity: 1,
                    ),
                  );
                }
              : null,
            icon: const Icon(
              Icons.add,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}