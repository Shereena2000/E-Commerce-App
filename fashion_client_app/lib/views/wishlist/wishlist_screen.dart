import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/provider/wishlist_provider.dart';
import 'package:fashion_client_app/widgets/product_card.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          "Wishlist",
          style: appBarText,
        ),
      ),body: Consumer<WishlistProvider>(builder: (context,wishlistProvider,child){
         if (wishlistProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
            
          }
   final products = wishlistProvider.wishlistProducts;
   if (products.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Your wishlist is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
      return    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                    );
      },)
    );
  }
}
