import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fashion_client_app/controllers/connectivity_service.dart';
import 'package:fashion_client_app/model/products_model.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/views/cart/widgets/cart_item.dart';
import 'package:fashion_client_app/views/cart/widgets/order_summary.dart';
import 'package:fashion_client_app/views/offline/offline_screen.dart';
import 'package:fashion_client_app/widgets/custom_app_bar.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:fashion_client_app/widgets/custom_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final connectivityService = Provider.of<ConnectivityService>(context, listen: false);

    return StreamBuilder<List<ConnectivityResult>>(
      stream: connectivityService.connectivityStream,
      builder: (context, connectivitySnapshot) {
        // Check if the device is offline
        final bool isOffline = connectivitySnapshot.hasData &&
            connectivitySnapshot.data!.contains(ConnectivityResult.none);

        // If offline, show a text message on the Scaffold
        if (isOffline) {
          return OfflineScreen();
        }

    return Scaffold(
      appBar: const CustomAppBar(title: "Shopping Cart"),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (value.cart.isEmpty) {
              return const CustomEmptyWidget(asset: "assets/empty.json",text: "Your bag is currently empty...",);
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.cart.length,
                      itemBuilder: (context, index) {
                        if (index >= value.product.length) {
                          return const SizedBox();
                        }
                        ProductModels matchingProduct =
                            value.product.firstWhere(
                          (p) => p.id == value.cart[index].productId,
                          orElse: () => ProductModels(
                            name: "Unknown Product",
                            description: "No description available",
                            images: [],
                            oldPrice: 0,
                            newPrice: 0,
                            category: "Unknown",
                            id: value.cart[index].productId,
                            maxQuantity: 0,
                            colorVariants: [],
                            sizeVariants: [],
                          ),
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
                  OrderSummary(totalCost: value.totalCost.toString()),
                  CustomButton(
                      text: "Place Order",
                      onPressed: () {
                        Navigator.pushNamed(context, '/checkout');
                      })
                ],
              );
            }
          }
        },
      ),
    );
  }
  );
  }
}


