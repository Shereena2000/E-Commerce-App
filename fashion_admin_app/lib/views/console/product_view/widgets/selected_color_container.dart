import 'package:flutter/material.dart';

class SelectedColorContainer extends StatelessWidget {
  final Color color;
  const SelectedColorContainer({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
    );
  }
}