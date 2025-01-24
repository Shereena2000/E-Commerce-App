import 'package:fashion_client_app/constants/dimension.dart';
import 'package:fashion_client_app/views/products/product_screen.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String category;
  final String image;
  const CategoryItem({
    
    super.key, required this.image, required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ProductScreen(category: category,)), // Replace NewScreen with your target screen
);
    },
      child: ClipRRect(
        borderRadius: radius5,
        child: Container(
          width: 150,
          height: 200,
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                 image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}