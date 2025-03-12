
import 'package:flutter/material.dart';

class SelectedColorContainer extends StatefulWidget {
  final Color color;
  final double size;
  
  const SelectedColorContainer({
    super.key, 
    required this.color,
    this.size = 35.0,
  });

  @override
  State<SelectedColorContainer> createState() => _SelectedColorContainerState();
}

class _SelectedColorContainerState extends State<SelectedColorContainer> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected 
            ? [BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                spreadRadius: 1,
              )]
            : null,
        ),
        child: isSelected 
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
          : null,
      ),
    );
  }
}