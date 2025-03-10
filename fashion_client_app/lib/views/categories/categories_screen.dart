// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:fashion_client_app/controllers/connectivity_service.dart';
// import 'package:fashion_client_app/utils/app_utils.dart';
// import 'package:fashion_client_app/views/categories/service/categories_service.dart';
// import 'package:fashion_client_app/views/categories/widgets/categoey_header.dart';
// import 'package:fashion_client_app/views/categories/widgets/category_card.dart';
// import 'package:fashion_client_app/views/offline/offline_screen.dart';
// import 'package:fashion_client_app/widgets/custom_empty_widget.dart';
// import 'package:fashion_client_app/widgets/custom_main_app_bar.dart';
// import 'package:fashion_client_app/widgets/discount_container.dart';
// import 'package:flutter/material.dart';
// import 'package:fashion_client_app/model/categories_model.dart';
// import 'package:provider/provider.dart';

// class CategoriesScreen extends StatelessWidget {
//   const CategoriesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final categoriesService = CategoriesService();
//      final connectivityService = Provider.of<ConnectivityService>(context, listen: false);

//     return StreamBuilder<List<ConnectivityResult>>(
//       stream: connectivityService.connectivityStream,
//       builder: (context, connectivitySnapshot) {
//         // Check if the device is offline
//         final bool isOffline = connectivitySnapshot.hasData &&
//             connectivitySnapshot.data!.contains(ConnectivityResult.none);

//         // If offline, show a text message on the Scaffold
//         if (isOffline) {
//           return OfflineScreen();
//         }
//     return Scaffold(
//       appBar:const CustomMainAppBar(),
//       body: Column(
//         children: [
//           const DiscountContainer(),
//           Expanded(
//             child: StreamBuilder(
//               stream: categoriesService.fetchCategories(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 if (snapshot.hasData) {
//                   final categories = snapshot.data!;
//                   if (categories.isEmpty) {
//                     return const CustomEmptyWidget(
//                         text: "Category Unavailble",
//                         asset: "assets/dress.json");
//                   }

//                   return ListView(
//                     padding: const EdgeInsets.all(8.0),
//                     children: categoryTypes.map((type) {
//                       final filteredCategories = categoriesService
//                           .filterCategoriesByType(categories, type);
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CategoryHeader(
//                               type: type,
//                             ),
//                             const SizedBox(height: 8.0),
//                             LimitedBox(
//                               maxHeight: 230,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: filteredCategories.length,
//                                 itemBuilder: (context, index) {
//                                   CategoriesModel category =
//                                       filteredCategories[index];
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8.0),
//                                     child: CategoryCard(
//                                         categoryImage: category.image,
//                                         categoryName: category.name),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text("Error: ${snapshot.error}"),
//                   );
//                 } else {
//                   return const Center(
//                     child: Text("No categories found."),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );});
//   }
// }
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fashion_client_app/controllers/connectivity_service.dart';
import 'package:fashion_client_app/utils/app_utils.dart';
import 'package:fashion_client_app/views/categories/service/categories_service.dart';
import 'package:fashion_client_app/views/categories/widgets/categoey_header.dart';
import 'package:fashion_client_app/views/categories/widgets/category_card.dart';
import 'package:fashion_client_app/views/offline/offline_screen.dart';
import 'package:fashion_client_app/widgets/custom_empty_widget.dart';
import 'package:fashion_client_app/widgets/custom_main_app_bar.dart';
import 'package:fashion_client_app/widgets/discount_container.dart';
import 'package:flutter/material.dart';
import 'package:fashion_client_app/model/categories_model.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesService _categoriesService = CategoriesService();
  StreamSubscription<List<CategoriesModel>>? _categoriesSubscription;
  List<CategoriesModel> _categories = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _listenToCategories();
  }

  void _listenToCategories() {
    _categoriesSubscription = _categoriesService.fetchCategories().listen(
      (data) {
        setState(() {
          _categories = data;
          _isLoading = false;
        });
      },
      onError: (error) {
        setState(() {
          _errorMessage = "Error: $error";
          _isLoading = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _categoriesSubscription?.cancel(); // Stop listening when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connectivityService =
        Provider.of<ConnectivityService>(context, listen: false);

    return StreamBuilder<List<ConnectivityResult>>(
      stream: connectivityService.connectivityStream,
      builder: (context, connectivitySnapshot) {
        final bool isOffline = connectivitySnapshot.hasData &&
            connectivitySnapshot.data!.contains(ConnectivityResult.none);

        if (isOffline) {
          return OfflineScreen();
        }

        return Scaffold(
          appBar: const CustomMainAppBar(),
          body: Column(
            children: [
              const DiscountContainer(),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                        ? Center(child: Text(_errorMessage!))
                        : _categories.isEmpty
                            ? const CustomEmptyWidget(
                                text: "Category Unavailable",
                                asset: "assets/dress.json",
                              )
                            : ListView(
                                padding: const EdgeInsets.all(8.0),
                                children: categoryTypes.map((type) {
                                  final filteredCategories =
                                      _categoriesService.filterCategoriesByType(
                                          _categories, type);
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CategoryHeader(type: type),
                                        const SizedBox(height: 8.0),
                                        LimitedBox(
                                          maxHeight: 230,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                filteredCategories.length,
                                            itemBuilder: (context, index) {
                                              CategoriesModel category =
                                                  filteredCategories[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: CategoryCard(
                                                  categoryImage:
                                                      category.image,
                                                  categoryName:
                                                      category.name,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
              ),
            ],
          ),
        );
      },
    );
  }
}
