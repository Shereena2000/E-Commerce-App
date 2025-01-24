import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final String type;
  const CategoryHeader({
    super.key, required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const Icon(
          Icons.arrow_forward_ios,
          size: 12,
        )
      ],
    );
  }
}
