import 'package:fashion_admin_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class CategoryDropDown extends StatelessWidget {
    final String selectedValue;
  final ValueChanged<String?> onChanged;
  const CategoryDropDown({
    super.key, required this.selectedValue, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      hint: const Text("Select a type"),
      items: categoryTypes.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) =>
          value == null ? "Please select a type" : null,
    );
  }
}

