import 'package:fashion_admin_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';

class ColorSelectingDialog extends StatelessWidget {
  const ColorSelectingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      title: const Text("Pick colors!"),
      content: Wrap(
        children: colorMap.keys
            .map((color) {
          return Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              bool isSelected = productProvider.selectedColors.contains(color);
              return GestureDetector(
                onTap: () => productProvider.toggleColor(color),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color:colorMap[color],
                        shape: BoxShape.circle,
                        border: Border.all(color: blackColor, width: 3)),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("DONE"),
        ),
      ],
    );
  }
}
