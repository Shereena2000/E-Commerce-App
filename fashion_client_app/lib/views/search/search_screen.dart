import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/model/products_model.dart';
import 'package:fashion_client_app/provider/filter_state_provider.dart';
import 'package:fashion_client_app/provider/search_provider.dart';
import 'package:fashion_client_app/views/products/widgets/filter_and_sort_button.dart';
import 'package:fashion_client_app/views/search/services/product_search_service.dart';
import 'package:fashion_client_app/views/search/widgets/product_search_bar.dart';
import 'package:fashion_client_app/widgets/custom_app_bar.dart';
import 'package:fashion_client_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filterState = Provider.of<FilterStateProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: "Search Products"),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: ProductSearchBar(),
          ),
          const FilterAndSortButton(),
          liteSpacing,
          Expanded(
            child: StreamBuilder<List<ProductModels>>(
        
              stream: ProductSearchService().searchProducts(
                context.watch<SearchProvider>().searchQuery,
                selectedSize: filterState.selectedSize,
                selectedColor: filterState.selectedColor,
                selectedPriceRange: filterState.selectedPriceRange,
              ),
              builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Eroor:${snapshot.error}"),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No products found"));
                }
                final products = snapshot.data!;

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                );
           
              },
            ),
          ),
        ],
      ),
    );
  }
}