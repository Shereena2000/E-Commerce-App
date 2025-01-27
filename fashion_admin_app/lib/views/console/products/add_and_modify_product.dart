import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';
import 'package:fashion_admin_app/utils/form_validator.dart';
import 'package:fashion_admin_app/views/console/products/widgets/category_selector_section.dart';
import 'package:fashion_admin_app/views/console/products/widgets/image_selector_widget.dart';
import 'package:fashion_admin_app/views/console/products/widgets/size_color_selctor_section.dart';
import 'package:fashion_admin_app/widgets/custom_button.dart';
import 'package:fashion_admin_app/widgets/custom_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAndModifyProduct extends StatelessWidget {
  final bool isUpdating;

  final String? id;
  const AddAndModifyProduct({super.key, required this.isUpdating, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdating ? "MODIFY PRODUCT" : "ADD PRODUCT"),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          List<String> imageUrls = provider.imageUrlsController.text.isNotEmpty
              ? provider.imageUrlsController.text.split(',')
              : [];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: provider.formKey,
                child: Column(
                  children: [
                    _buildProductDetailsSection(provider),
                    smallSpacing,
                    CategorySelectorSection(
                      provider: provider,
                    ),
                    smallSpacing,
                    _buildDescriptionField(provider),
                    smallSpacing,
                    SizeColorSelctorSection(provider: provider),
                    ImageSelectorWidget(
                      provider: provider,
                      imageUrls: imageUrls,
                    ),
                    smallSpacing,
                    CustomButton(
                      text: isUpdating ? 'Submit' : 'Add',
                      onPressed: () {
                        provider.handleSubmit(
                            context, isUpdating, isUpdating ? id! : "");
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextFormField _buildDescriptionField(ProductProvider provider) {
    return TextFormField(
      controller: provider.discriptionController,
      validator: (value) => validateNotEmpty(value),
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Description',
        hintText: 'Description',
        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildProductDetailsSection(ProductProvider provider) {
    return Column(
      children: [
        CustomTextFormFeild(
          icon: Icons.checkroom,
          hint: "Product Name",
          label:  "Product Name",
          controller: provider.nameController,
          validator: (value) =>
              validateNotEmpty(value),
        ),
        smallSpacing,
        CustomTextFormFeild(
          icon: Icons.attach_money,
          hint: "Original Price",
          label:  "Original Price",
          controller: provider.oldPriceController,
          validator: (value) => validateNotEmpty(value),
        ),
        smallSpacing,
        CustomTextFormFeild(
          icon: Icons.shopify_sharp,
          label: "Sell Price",
          hint: "Sell Price",
          controller: provider.newPriceController,
          validator: (value) => validateNumber(value),
        ),
        smallSpacing,
        CustomTextFormFeild(
          icon: Icons.shopping_bag_outlined,
          hint: "Quantity Left",
          label: "Quantity Left",
          controller: provider.quantityController,
          validator: (value) => validateNumber(value),
        ),
      ],
    );
  }
}
