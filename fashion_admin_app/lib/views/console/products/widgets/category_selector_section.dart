import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';
import 'package:fashion_admin_app/views/console/products/widgets/show_category_dialog.dart';
import 'package:flutter/material.dart';

class CategorySelectorSection extends StatelessWidget {
   final ProductProvider provider;
  const CategorySelectorSection({
    super.key, required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: provider.categoriesController,
      validator: (value) =>
          value!.isEmpty ? "This field cannot be empty" : null,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: colorTheme,
            child: Icon(Icons.category_outlined,
                color: Colors.white),
          ),
        ),
        hintText: "Category",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      onTap: () {
        showCategoryDialog(context,provider);
      },
    );
  }

}