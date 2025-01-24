import 'package:fashion_admin_app/providers/category_provider.dart';
import 'package:fashion_admin_app/utils/form_validator.dart';
import 'package:flutter/material.dart';

class CategoryNameField extends StatelessWidget {
    final CategoryProvider provider;
  const CategoryNameField({
    super.key, required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: provider.categoryController,
      validator: (value) =>
         validateNotEmpty(value),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Category Name',
        labelText: 'Category Name',
      ),
    );
  }
}

