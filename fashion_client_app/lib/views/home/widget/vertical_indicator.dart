import 'package:fashion_client_app/constants/colors.dart';
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
      top: MediaQuery.of(context).size.height / 2, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalPages,
          (index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: 8,
            height: 8,
            decoration: BoxDecoration(

              color: verticalPageIndex == index
                  ? whiteColor 
                  : const Color.fromARGB(134, 198, 197, 197) 
            ),
          ),
        ),
      ),
    );
  }
}