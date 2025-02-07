
import 'package:flutter/material.dart';

class BuildTextFeild extends StatelessWidget {
  const BuildTextFeild(
      {super.key,
      required this.controller,
      required this.label,
      required this.validator,
      this.maxLines = 1});

  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
    );
  }
}