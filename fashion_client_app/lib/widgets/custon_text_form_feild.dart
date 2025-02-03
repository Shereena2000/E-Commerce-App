import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
    final bool readOnly;
  const CustomTextFormFeild({
    super.key,
    required this.hint,
    this.controller,
    this.validator,
    required this.label, this.readOnly=false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
    );
  }
}
