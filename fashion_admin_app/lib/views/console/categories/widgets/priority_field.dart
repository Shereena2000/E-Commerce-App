import 'package:fashion_admin_app/providers/category_provider.dart';
import 'package:fashion_admin_app/utils/form_validator.dart';
import 'package:flutter/material.dart';

class PriorityField extends StatelessWidget {
    final CategoryProvider provider;
  const PriorityField({
    super.key, required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: provider.priorityController,
      validator: (value) => validateNotEmpty(value),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Priority',
        labelText: 'Priority',
      ),
    );
  }
}

