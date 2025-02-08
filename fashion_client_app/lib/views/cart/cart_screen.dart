import 'package:fashion_client_app/constants/texts.dart';
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
                    child: ListView.builder(
                      itemCount: value.cart.length,
                      itemBuilder: (context, index) {
                        if (index >= value.product.length) {
                          return const SizedBox(); // Prevent index out of bounds
                        }

                        return CartItem(
                          image: (value.product[index].images.isNotEmpty)
                              ? value.product[index].images[0]
                              : "assets/placeholder.jpg",
                          name: value.product[index].name,
                          newPrice: value.product[index].newPrice,
                          size: value.cart[index].size,
                          color: value.cart[index].color,
                          cartId: value.cart[index].cartId,
                          maxQuantity:
                              value.product[index].maxQuantity, // Add this
                          productId: value.product[index].id,
                        );
                      },
                    ),
                  ),
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


// class CouponInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//           hintText: "Enter Coupon code",
//           suffixIcon: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: whiteColor,
//               ),
//               onPressed: () {},
//               child: const Text("Apply"),
//             ),
//           ),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//       ),
//     );
//   }
// }


