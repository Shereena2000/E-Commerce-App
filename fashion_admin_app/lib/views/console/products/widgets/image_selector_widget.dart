import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageSelectorWidget extends StatelessWidget {
  final ProductProvider provider;
  final List<String> imageUrls;
  const ImageSelectorWidget({
    super.key,
    required this.provider,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
      List<String> imageUrls = provider.imageUrlsController.text.isNotEmpty
      ? provider.imageUrlsController.text.split(',').where((url) => url.isNotEmpty && url.startsWith('http')).toList()
      : [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            provider.pickImagesAndUpload();
          },
          icon: const Icon(
            Icons.add_a_photo,
            color: blackColor,
            size: 40,
          ),
        ),
        const Text('Pick Image'),
        const SizedBox(height: 10),
        provider.isLoading
            ? const CircularProgressIndicator() // Show loading indicator for overall process
            : imageUrls.isNotEmpty
                ? Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: imageUrls.asMap().entries.map((entry) {
                      int index = entry.key;
                      String url = entry.value;
                      return Stack(
                        children: [
                          // Display the uploaded image
                          Image.network(
                            url,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Image is fully loaded
                              }
                              // Show a circular progress indicator while the image is loading
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                          // Close button to remove the image
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: blueColor,
                                  width: 1.5,
                                ),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 15,
                                icon: const Icon(Icons.close, color: blueColor),
                                onPressed: () {
                                  Provider.of<ProductProvider>(context,
                                          listen: false)
                                      .removeImage(index);
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  )
                : const SizedBox(), // Show nothing if no images are uploaded
      ],
    );
  }
}