

import 'package:fashion_admin_app/constants/colors.dart';
import 'package:flutter/material.dart';

class SelectedSizeContainer extends StatefulWidget {
  final String size;
  final bool isDesktop;
  
  const SelectedSizeContainer({
    super.key, 
    required this.size,
    this.isDesktop = false,
  });

  @override
  State<SelectedSizeContainer> createState() => _SelectedSizeContainerState();
}

class _SelectedSizeContainerState extends State<SelectedSizeContainer> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final containerSize = widget.isDesktop ? 45.0 : 35.0;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: containerSize,
        width: containerSize,
        decoration: BoxDecoration(
          color: isSelected ? blackColor : Colors.transparent,
          border: Border.all(color: blackColor),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.size,
          style: TextStyle(
            color: isSelected ? whiteColor : blackColor,
            fontWeight: FontWeight.bold,
            fontSize: widget.isDesktop ? 16 : 14,
          ),
        ),
      ),
    );
  }
}
