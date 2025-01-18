import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SizeSelectingDialog extends StatelessWidget {
  const SizeSelectingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

    return AlertDialog(
      backgroundColor: whiteColor,
      title: const Center(child: Text("Select Size")),
      content: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          // Temporary selected sizes list, directly referring to the provider's state
          List<String> selectedSizes = productProvider.selectedSize;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: sizes.map((size) {
              return CheckboxListTile(
                title: Text(size),
                value: selectedSizes.contains(size),
                onChanged: (bool? value) {
                  // Toggle the selection of sizes
                  productProvider.toggleSize(size);
                },
              );
            }).toList(),
          );
        },
      ),
      actions: [
        
        TextButton(
          onPressed: () {
            final productProvider =
                Provider.of<ProductProvider>(context, listen: false);
            productProvider.setSelectedSize(productProvider.selectedSize);
           
            Navigator.pop(context);
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            side: const WidgetStatePropertyAll(
              BorderSide(color: colorTheme, width: 1.5),
            ),
          ),
          child: const Text("Save"),
        ),
      ],
    );
  }
}
