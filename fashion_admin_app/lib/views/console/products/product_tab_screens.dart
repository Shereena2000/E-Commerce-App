import 'package:fashion_admin_app/models/product_models.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';
import 'package:fashion_admin_app/views/console/products/add_and_modify_product.dart';
import 'package:fashion_admin_app/views/console/products/widgets/product_card.dart';
import 'package:fashion_admin_app/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTabScreens extends StatelessWidget {
  const ProductTabScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdminProviders>(builder: (context, value, child) {
        List<ProductModels> products =
            ProductModels.fromJsonList(value.products);

        if (products.isEmpty) {
          return const Center(
            child: Text("no products found"),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            (products[index].images.isNotEmpty)
                ? products[index].images[0]
                : "https://demofree.sirv.com/nope-not-here.jpg";
            return ProductCard(
            
              products: products[index],
            );
          },
          itemCount: products.length,
        );
      }),
      floatingActionButton: CustomFloatingActionButton(onPressed: () {
      Provider.of<ProductProvider>(context, listen: false).clearForm();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddAndModifyProduct(
                      isUpdating: false,
                   
                    )));
      }),
    );
  }
}
