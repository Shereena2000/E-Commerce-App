import 'package:fashion_admin_app/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomTextFormFeild({
    super.key, required this.icon, required this.hint,  this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: colorTheme,
            child: Icon(icon, color: Colors.white),
          ),
        ),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
    );


  }
}
