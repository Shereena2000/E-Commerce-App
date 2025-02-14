import 'package:fashion_client_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class ProductSubTitle extends StatelessWidget {
  final String productName;
  final String newPrice;
  // final String originalPrice;
  const ProductSubTitle({
    super.key,
    required this.productName,
    required this.newPrice,
    // required this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productName.titleCase,
          style:const TextStyle(fontSize: 13),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text('₹$newPrice',
            style:const TextStyle(color: greenColor, fontWeight: FontWeight.bold)),
       
      ],
    );
  }
}
