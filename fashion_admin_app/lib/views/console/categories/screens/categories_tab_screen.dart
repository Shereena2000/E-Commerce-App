import 'package:fashion_admin_app/models/categories_model.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/views/console/categories/widgets/add_and_modify_category.dart';
import 'package:fashion_admin_app/views/console/categories/widgets/category_list_item.dart';
import 'package:fashion_admin_app/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesTabScreen extends StatelessWidget {
  const CategoriesTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdminProviders>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<CategoriesModel> categories =
              CategoriesModel.fromJsonList(value.categories);
          if (categories.isEmpty) {
            return const Center(
              child: Text("No Categories Found"),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryListItem(categories: categories[index]);
            },
          );
        },
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddAndModifyCategory(
              isUpdating: false,
              categoryId: "",
              priority: 0,
              type: "",
            ),
          );
        },
      ),
    );
  }
}
