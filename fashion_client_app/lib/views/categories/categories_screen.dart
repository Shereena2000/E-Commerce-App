import 'package:fashion_client_app/utils/app_utils.dart';
import 'package:fashion_client_app/views/categories/service/categories_service.dart';
import 'package:fashion_client_app/views/categories/widgets/categoey_header.dart';
import 'package:fashion_client_app/views/categories/widgets/category_card.dart';
import 'package:fashion_client_app/widgets/custom_main_app_bar.dart';
import 'package:fashion_client_app/widgets/discount_container.dart';
import 'package:flutter/material.dart';
import 'package:fashion_client_app/model/categories_model.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesService = CategoriesService();
    return Scaffold(
      appBar: CustomMainAppBar(),
      body: Column(
    
        children: [
                const DiscountContainer(), 
          Expanded(
            child: StreamBuilder(
              stream: categoriesService.fetchCategories(),
              builder: (context, snapshot) {
             
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
            
                if (snapshot.hasData) {
                  final categories = snapshot.data!;
                  if (categories.isEmpty) {
                    return const Center(
                      child: Text("No categories available"),
                    );
                  }
            
                  return ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: categoryTypes.map((type) {
                      final filteredCategories =
                          categoriesService.filterCategoriesByType(categories, type);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CategoryHeader(
                              type: type,
                            ),
                            const SizedBox(height: 8.0),
                            LimitedBox(
                              maxHeight: 230,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: filteredCategories.length,
                                itemBuilder: (context, index) {
                                  CategoriesModel category =
                                      filteredCategories[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: CategoryCard(
                                        categoryImage: category.image,
                                        categoryName: category.name),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  return const Center(
                    child: Text("No categories found."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
