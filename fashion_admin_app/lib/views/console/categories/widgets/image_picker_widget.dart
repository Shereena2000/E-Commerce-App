import 'dart:io';

import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/providers/category_provider.dart';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final CategoryProvider provider;
  const ImagePickerWidget({
    super.key, required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        provider.pickImageAndUpload();
      },
      child: provider.image == null
          ? provider.imageController.text.isNotEmpty
              ? Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    provider.imageController.text,
                    fit: BoxFit.contain,
                  ))
              : Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorTheme),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.image,
                          size: 60, color: colorTheme),
                      Text('Pick Image'),
                    ],
                  ),
                )
          : Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.file(
                File(provider.image!.path),
                fit: BoxFit.contain,
              ),
            ),
    );
  }
}