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
      left: 20,
      top: MediaQuery.of(context).size.height / 2 - 10,
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(
          'Page ${verticalPageIndex + 1}/$totalPages',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

