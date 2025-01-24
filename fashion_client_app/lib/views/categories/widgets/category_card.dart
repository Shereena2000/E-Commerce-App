
import 'package:fashion_client_app/views/categories/widgets/category_item.dart';
import 'package:fashion_client_app/widgets/sub_title.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String categoryImage;
  final String categoryName;
  const CategoryCard({     
    super.key,
   required this.categoryImage, required this.categoryName,
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryItem(image: categoryImage,category: categoryName,),
        const SizedBox(height: 4.0),
        SubTitle(title: categoryName),
      ],
    );
  }
}
