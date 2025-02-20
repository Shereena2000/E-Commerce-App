import 'package:fashion_admin_app/constants/colors.dart';
import 'package:flutter/material.dart';

class SelectedSizeContainer extends StatelessWidget {
  final String size;
  const SelectedSizeContainer({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: blackColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        size,
        style: const TextStyle(color: blackColor),
      ),
    );
  }
}


