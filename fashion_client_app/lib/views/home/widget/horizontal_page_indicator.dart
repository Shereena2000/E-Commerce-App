import 'package:flutter/material.dart';

class HorizontalPageIndicator extends StatelessWidget {
  final PageController horizontalController;
  final int pageCount;

  const HorizontalPageIndicator({
    required this.horizontalController,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: MediaQuery.of(context).size.width / 2 - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pageCount,
          (index) => AnimatedBuilder(
            animation: horizontalController,
            builder: (context, child) {
              double currentPage = horizontalController.hasClients
                  ? horizontalController.page ?? 0
                  : 0;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: (index == currentPage.round())
                      ? Colors.white
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
