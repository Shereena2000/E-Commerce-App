import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/models/categories_model.dart';
import 'package:fashion_admin_app/views/console/categories/add_and_modify_category.dart';
import 'package:fashion_admin_app/widgets/additional_confirm.dart';
import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  final CategoriesModel categories;
  const CategoryListItem({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        color: beigeColor,
        boxShadow: [
          BoxShadow(
            color: beigeLiteShadowColor,
            blurRadius: 15,
            offset: Offset(4, 4),
          ),
          BoxShadow(
            color: beigeDarkShadowColor,
            blurRadius: 15,
            offset: Offset(-4, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.network(categories.image == ""
                  ? "https://demofree.sirv.com/nope-not-here.jpg"
                  : categories.image),
            ),
            smallWidthSpacing,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(categories.name, style: boldText),
                  Text("Priority: ${categories.priority}"),
                  Text("Type: ${categories.type}"),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 18,
                  ),
                  onPressed: () {
                    showDeleteDialog(context);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    size: 18,
                  ),
                  onPressed: () {
                    showEditDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AdditionalConfirm(
              contentText: "Are you sure you want to delete this?",
              onNo: () {
                Navigator.pop(context);
              },
              onYes: () {
                DbService().deleteCategories(doId: categories.id);
                Navigator.pop(context);
              },
            ));
  }

  void showEditDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AddAndModifyCategory(
              isUpdating: true,
              categoryId: categories.id,
              priority: categories.priority,
              type: categories.type,
              image: categories.image,
              name: categories.name,
            ));
  }
}
