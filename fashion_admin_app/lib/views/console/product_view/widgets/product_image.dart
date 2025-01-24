import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/models/product_models.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({
    super.key,
    required this.width,
    required this.products,
  });

  final double width;
  final ProductModels products;

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widget.width,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(widget.products.images[selectedImage]),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.products.images.length,
                (index) => buildSmallPreview(index))
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 15, top: 15),
        width: 50,
        decoration: BoxDecoration(
            color: beigeColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color:
                    selectedImage == index ?blackColor : Colors.transparent)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(widget.products.images[index])),
      ),
    );
  }
}
