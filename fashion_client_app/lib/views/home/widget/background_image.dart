import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String imageUrl;

  const BackgroundImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {

    final bool isValidUrl = imageUrl.isNotEmpty &&
        (imageUrl.startsWith('http://') || imageUrl.startsWith('https://'));
    print(imageUrl);
    return isValidUrl
        ? Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return _buildFallbackImage("Failed to load image");
            },
          )
        : _buildFallbackImage("Invalid image URL");
  }

  Widget _buildFallbackImage(String message) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image_not_supported,
              color: Colors.white,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
