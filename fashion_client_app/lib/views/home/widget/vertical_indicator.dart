import 'package:flutter/material.dart';

class VerticalPageIndicator extends StatelessWidget {
  final int verticalPageIndex;
  final int totalPages;

  const VerticalPageIndicator({
    required this.verticalPageIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20, // Adjust the position as needed
      top: MediaQuery.of(context).size.height / 2 - (totalPages * 10), // Center vertically
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalPages,
          (index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: verticalPageIndex == index
                  ? Colors.white // Highlighted dot
                  : Colors.grey.withOpacity(0.5), // Unhighlighted dot
            ),
          ),
        ),
      ),
    );
  }
}