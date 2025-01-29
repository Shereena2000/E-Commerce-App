import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return TextField(
      controller: searchController,
      cursorColor: blackColor,
      onChanged: (value) {
        context.read<SearchProvider>().updateSearchQuery(value);
      },
      decoration: InputDecoration(
         contentPadding: const EdgeInsets.symmetric(vertical: 10), 

        prefixIcon: const Icon(Icons.search),
        hintText: "Search all....",
        suffixIcon: IconButton(
          icon:const Icon(
            Icons.close,
            size: 20,
          ),
          onPressed: () {
            searchController.clear();
              context.read<SearchProvider>().updateSearchQuery('');
          },
        ),
        focusColor: greyColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: greyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: greyColor),
        ),
      ),
    );
  }
}
