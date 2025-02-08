import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/utils/app_utils.dart';
import 'package:fashion_client_app/views/cart/widgets/quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String image, name, productId, cartId, color, size;
  final int newPrice, maxQuantity;
  // selectedQuantity;
  CartItem({
    super.key,
    required this.image,
    required this.name,
    required this.productId,

    // required this.selectedQuantity,
    required this.newPrice,
    required this.cartId,
    required this.color,
    required this.size,
    required this.maxQuantity,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: whiteColor,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                    placeholder: "assets/placeholder.jpg",
                    image: image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, StackTrace) {
                      return Image.asset(
                        "assets/placeholder.jpg",
                        fit: BoxFit.contain,
                        width: 100,
                        height: 100,
                      );
                    }),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Text("Color: "),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 1),
                              color: colorMap[color] ?? Colors.transparent,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed:  () async {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .deleteItem(cartId);
                              },
                         icon:    Icon(Icons.delete_outline_outlined,
                            size: 20,)
                          )
                        ],
                      ),
                      Text("Size: $size"),
                      Text(" \₹$newPrice",
                          style: const TextStyle(color: greenColor)),
                      smallSpacing,
                      Row(
                        children: [
                          QuantitySelector(
                            cartId: cartId,
                            quantity: context
                                .watch<CartProvider>()
                                .cart
                                .firstWhere((item) => item.cartId == cartId)
                                .quantity,
                            maxQuantity:
                                10, // You can get this from your product model
                          ),
                          const Spacer(),
                          Text(
                            "Total: ₹${newPrice * context.watch<CartProvider>().cart.firstWhere((item) => item.cartId == cartId).quantity}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                     
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
