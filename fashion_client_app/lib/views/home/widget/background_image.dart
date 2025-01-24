import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String imageUrl;

  const BackgroundImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}