import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/models/product_models.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';
import 'package:fashion_admin_app/views/console/products/add_and_modify_product.dart';
import 'package:fashion_admin_app/views/console/product_view/product_view_screen.dart';
import 'package:fashion_admin_app/widgets/additional_confirm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class ProductCard extends StatelessWidget {
  final ProductModels products;
  const ProductCard({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductViewScreen(
                      products: products,
                    )));
      },
      child: Card(
        shadowColor: Colors.grey,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        color: beigeColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage.assetNetwork(
                placeholder: "assets/placeholder.jpg",
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
                image: products.images[0],
                imageErrorBuilder: (context, error, StackTrace) {
                  return Image.asset(
                    "assets/placeholder.jpg",
                    fit: BoxFit.contain,
                  );
                }),
            // Image.network(
            //   products.images[0],
            //   fit: BoxFit.cover,
            //   height: 150,
            //   width: double.infinity,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ReCase(products.name).titleCase,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${products.newPrice.toString()}',
                    style: const TextStyle(color: Colors.green),
                  ),
                  Text(
                    products.category,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AdditionalConfirm(
                              contentText:
                                  " Are you sure you want to delete this?",
                              onYes: () {
                                DbService().deleteProducts(doId: products.id);
                                Navigator.pop(context);
                              },
                              onNo: () {
                                Navigator.pop(context);
                              }));
                    },
                    icon: const Icon(Icons.delete, size: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .updateProductDetails(products);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAndModifyProduct(
                            isUpdating: true,
                            id: products.id,
                            // name: products.name,
                            // oldPrice: products.oldPrice.toString(),
                            // newPrice: products.newPrice.toString(),
                            // quantity: products.maxQuantity.toString(),
                            // category: products.category,
                            // description: products.description,
                            // sizeVariants: products.sizeVariants,
                            // colorVariants: products.colorVariants,
                            // imageUrl: products.images,
                            // id: products.id,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit, size: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
