
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/models/categories_model.dart';
import 'package:fashion_admin_app/models/product_models.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';
import 'package:fashion_admin_app/views/console/products/screens/add_and_modify_product.dart';
import 'package:fashion_admin_app/views/console/products/widgets/product_grid.dart';
import 'package:fashion_admin_app/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTabScreens extends StatefulWidget {
  const ProductTabScreens({super.key});

  @override
  State<ProductTabScreens> createState() => _ProductTabScreensState();
}

class _ProductTabScreensState extends State<ProductTabScreens> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  
  @override
  Widget build(BuildContext context) {
   // final isDesktop = MediaQuery.of(context).size.width > 600;
    
    return Scaffold(
      body: Column(
        children: [
          // Responsive filter and search bar
          Container(
            padding: const EdgeInsets.all(16),
            child: _buildFilters()
          ),
          
          // Product grid or empty state
          Expanded(
  child: Consumer<AdminProviders>(
    builder: (context, value, child) {
      List<ProductModels> allProducts = ProductModels.fromJsonList(value.products);

      // Apply search filter
      List<ProductModels> filteredProducts = allProducts.where((product) {
        final matchesSearch = product.name.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesCategory = _selectedCategory == 'All' || product.category == _selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();

      if (filteredProducts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.inventory, size: 72, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                "No products found",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (_searchQuery.isNotEmpty || _selectedCategory != 'All')
                TextButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text("Clear filters"),
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                      _selectedCategory = 'All';
                    });
                  },
                ),
            ],
          ),
        );
      }

      return ProductGrid(products: filteredProducts);
    },
  ),
),

        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Provider.of<ProductProvider>(context, listen: false).clearForm();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAndModifyProduct(
                isUpdating: false,
              ),
            ),
          );
        },
      ),
    );
  }
  
  // Desktop layout for filters (horizontal arrangement)
  Widget _buildFilters() {
    return Row(
      children: [
        // Category dropdown
        Expanded(
          flex: 3,
          child: _buildCategoryDropdown(),
        ),
        const SizedBox(width: 16),
        
        // Search field
        Expanded(
          flex: 2,
          child: _buildSearchField(),
        ),
      ],
    );
  }
  
  
Widget _buildCategoryDropdown() {
  return StreamBuilder<QuerySnapshot>(
    stream: DbService().readCategories(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const CircularProgressIndicator();
      }

      List<CategoriesModel> categories = CategoriesModel.fromJsonList(snapshot.data!.docs);
      List<String> categoryNames = ['All'] + categories.map((cat) => cat.name).toList();

      return DropdownButtonFormField2<String>(
        value: _selectedCategory,
        decoration: InputDecoration(
          labelText: 'Category',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        items: categoryNames.map((category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedCategory = value ?? 'All';
          });
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200, // Limits dropdown height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 48, // Adjusts individual item height
        ),
      );
    },
  );
}


  
  // Search field widget
  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search products...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: _searchQuery.isNotEmpty 
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _searchQuery = '';
                  });
                },
              )
            : null,
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
    );
  }
}
