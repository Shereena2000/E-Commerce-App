import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/models/categories_model.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/views/selling/categories/add_and_modify_category.dart';
import 'package:fashion_admin_app/widgets/additional_confirm.dart';
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
            padding:const EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: const BoxDecoration(
                  color: beigeColor,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 226, 224, 213),
                      blurRadius: 15,
                      offset: Offset(4, 4),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 238, 234, 207),
                      blurRadius: 15,
                      offset: Offset(-4, -4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(categories[index].image == "" ||
                                  categories[index].image == null
                              ? "https://demofree.sirv.com/nope-not-here.jpg"
                              : categories[index].image)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(categories[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Priority: ${categories[index].priority}"),
                          Text("Type: ${categories[index].type}"),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              size: 18,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AdditionalConfirm(
                                        contentText:
                                            "Are you sure you want to delete this",
                                        onNo: () {
                                          Navigator.pop(context);
                                        },
                                        onYes: () {
                                          DbService().deleteCategories(
                                              doId: categories[index].id);
                                          Navigator.pop(context);
                                        },
                                      ));
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 18,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AddAndModifyCategory(
                                        isUpdating: true,
                                        categoryId: categories[index].id,
                                        priority: categories[index].priority,
                                        type: categories[index].type,
                                        image: categories[index].image,
                                        name: categories[index].name,
                                      ));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorTheme,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => const AddAndModifyCategory(
                    isUpdating: false,
                    categoryId: "",
                    priority: 0,
                    type: "",
                  ));
        },
        child: const Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
    );
  }
}

