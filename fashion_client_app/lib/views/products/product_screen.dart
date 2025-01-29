import 'package:fashion_client_app/views/products/services/product_service.dart';
import 'package:fashion_client_app/widgets/product_card.dart';
import 'package:fashion_client_app/widgets/app_bar_logo_title.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final String category;
  const ProductScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    return Scaffold(
      appBar: AppBar(
        title: const AppBarLogoTitle(),
      ),
      body: StreamBuilder(
        stream: productService.fetchProductsByCategory(category),
        // stream: DbService().readProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            // List<ProductModels> products = ProductModels.fromJsonList(snapshot.data!.docs);
            // List<ProductModels> filteredProducts = products.where((product) => product.category == category).toList();
            final products = snapshot.data!;
            if (products.isEmpty) {
              return const Center(child: Text("No products available"));
            }

            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return const Center(
              child: Text("No categories found."),
            );
          }
        },
      ),
    );
  }
}
