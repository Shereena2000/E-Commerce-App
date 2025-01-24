import 'package:flutter/material.dart';

class ProductSubTitle extends StatelessWidget {
  final String productName;
  final String newPrice;
  final String originalPrice;
  const ProductSubTitle({

    super.key, required this.productName, required this.newPrice, required this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
     
     mainAxisSize: MainAxisSize.min,
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productName
          ,
          style: TextStyle(fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(newPrice,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        Text(
         originalPrice,
          style: TextStyle(
            decoration: TextDecoration.lineThrough,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
