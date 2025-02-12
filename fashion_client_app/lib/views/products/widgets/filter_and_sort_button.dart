import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/provider/filter_state_provider.dart';
import 'package:fashion_client_app/utils/app_utils.dart';
import 'package:fashion_client_app/views/products/widgets/filter_item.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FilterAndSortButton extends StatelessWidget {
  const FilterAndSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        buildFilterBottomSheet(context, width, height);
      },
      child: const Row(
        children: [
          Spacer(),
          Text("Filter & Sort"),
          litewidthspacing,
          Icon(Icons.filter_alt, size: 15),
          largerWidthSpacing,
        ],
      ),
    );
  }

  Future<dynamic> buildFilterBottomSheet(BuildContext context, double width, double height) {
    return showModalBottomSheet(
      backgroundColor: whiteColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Consumer<FilterStateProvider>(
              builder: (context, filterStateProvider, child) {
                return SizedBox(
                  width: width,
                  height: height / 0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        largerSpacing,
                        const Text(
                          "Filter",
                          style: mediumText,
                        ),
                        FilterItem(
                          text: "Size",
                          checklistItems: productSize,
                          filterStateProvider: filterStateProvider,
                        ),
                        FilterItem(
                          text: "Color",
                          checklistItems: productColor,
                          filterStateProvider: filterStateProvider,
                        ),
                        FilterItem(
                          text: "Prize Range",
                          checklistItems: productPriceRange,
                          filterStateProvider: filterStateProvider,
                        ),
                        largerSpacing,
                        CustomButton(
                          text: "Apply Filter",
                          onPressed: () {
                            // Apply the temporary filters
                            filterStateProvider.applyFilters();
                            Navigator.pop(context);
                          },
                        ),
                        largerSpacing,
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
