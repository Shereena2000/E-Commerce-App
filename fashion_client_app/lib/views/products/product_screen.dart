
import 'package:fashion_client_app/provider/filter_state_provider.dart';
import 'package:fashion_client_app/views/products/services/product_service.dart';
import 'package:fashion_client_app/views/products/widgets/filter_and_sort_button.dart';
import 'package:fashion_client_app/widgets/custom_app_bar.dart';
import 'package:fashion_client_app/widgets/custom_empty_widget.dart';
import 'package:fashion_client_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final String category;
  const ProductScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    final filterState = Provider.of<FilterStateProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: category),
      body: Column(
        children: [
          const FilterAndSortButton(),
          Expanded(
            child: StreamBuilder(
              stream: productService.fetchProductsByCategory(
                category,
                selectedSize: filterState.selectedSize,
                selectedColor: filterState.selectedColor,
                selectedPriceRange: filterState.selectedPriceRange,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final products = snapshot.data!;
                  if (products.isEmpty) {
                    return const CustomEmptyWidget(text: "Oops! No Products Here", asset: "assets/dress.json");
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
          ),
        ],
      ),
    );
  }
}
