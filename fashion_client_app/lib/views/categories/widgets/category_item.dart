import 'package:fashion_client_app/constants/dimension.dart';
import 'package:fashion_client_app/views/products/product_screen.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String category;
  final String image;
  const CategoryItem({
    super.key,
    required this.image,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductScreen(
                    category: category,
                  )),
        );
      },
      child: ClipRRect(
        borderRadius: radius5,
        child: Container(
          width: 150,
          height: 200,
         
          child: FadeInImage.assetNetwork(
            placeholder: "assets/placeholder.jpg",
            image: image,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, StackTrace) {
              return Image.asset(
                "assets/placeholder.jpg",
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }
}
