import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';
import 'package:fashion_admin_app/utils/app_utils.dart';
import 'package:fashion_admin_app/views/console/products/widgets/color_selecting_dialog.dart';
import 'package:fashion_admin_app/views/console/products/widgets/size_selecting_dialog.dart';
import 'package:flutter/material.dart';

class SizeColorSelctorSection extends StatelessWidget {
  final ProductProvider provider;
  const SizeColorSelctorSection({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSizeSelector(context),
        const Divider(
          color: greyColor,
        ),
        smallSpacing,
        _buldColorSelector(context),
      ],
    );
  }

  Widget _buldColorSelector(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const ColorSelectingDialog());
            },
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              side: const WidgetStatePropertyAll(
                BorderSide(color: greyColor, width: 1.5),
              ),
            ),
            child: const Text(
              "Select Color",
              style: TextStyle(color: blackColor),
            ),
          ),
        ),
        provider.selectedColors.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: provider.selectedColors.map((color) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: colorMap[color],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _buildSizeSelector(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select Size ',
              style: TextStyle(
                  color: blackColor, fontSize: 15, fontWeight: FontWeight.w500),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const SizeSelectingDialog());
              },
            )
          ],
        ),
        provider.selectedSize.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: provider.selectedSize.map((size) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: blackColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        size,
                        style: const TextStyle(color: blackColor),
                      ),
                    );
                  }).toList(),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
