import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/providers/product_provider.dart';
import 'package:fashion_admin_app/utils/app_utils.dart';
import 'package:fashion_admin_app/views/console/products/widgets/color_selecting_dialog.dart';
import 'package:fashion_admin_app/views/console/products/widgets/size_selecting_dialog.dart';
import 'package:fashion_admin_app/widgets/custom_button.dart';
import 'package:fashion_admin_app/widgets/custom_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:provider/provider.dart';

class AddAndModifyProduct extends StatelessWidget {
  final bool isUpdating;
 
  final String? id;
  const AddAndModifyProduct(
      {super.key,
      required this.isUpdating,
     
      this.id});

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
                    CustomTextFormFeild(
                      icon: Icons.checkroom,
                      hint: "Product Name",
                      controller: provider.nameController,
                      validator: (value) =>
                          value!.isEmpty ? "This field cannot be empty" : null,
                    ),
                    smallSpacing,
                    CustomTextFormFeild(
                      icon: Icons.attach_money,
                      hint: "Original Price",
                      controller: provider.oldPriceController,
                      validator: (value) => value!.isEmpty
                          ? "This field cannot be empty"
                          : int.tryParse(value) == null
                              ? "Enter a valid number"
                              : null,
                    ),
                    smallSpacing,
                    CustomTextFormFeild(
                      icon: Icons.shopify_sharp,
                      hint: "Sell Price",
                      controller: provider.newPriceController,
                      validator: (value) => value!.isEmpty
                          ? "This field cannot be empty"
                          : int.tryParse(value) == null
                              ? "Enter a valid number"
                              : null,
                    ),
                    smallSpacing,
                    CustomTextFormFeild(
                      icon: Icons.shopping_bag_outlined,
                      hint: "Quantity Left",
                      controller: provider.quantityController,
                      validator: (value) => value!.isEmpty
                          ? "This field cannot be empty"
                          : int.tryParse(value) == null
                              ? "Enter a valid number"
                              : null,
                    ),
                    smallSpacing,
                    TextFormField(
                      controller: provider.categoriesController,
                      validator: (value) =>
                          value!.isEmpty ? "This field cannot be empty" : null,
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: colorTheme,
                            child: Icon(Icons.category_outlined,
                                color: Colors.white),
                          ),
                        ),
                        hintText: "Category",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor: whiteColor,
                                  title:const Text("Select Category "),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.6),
                                        child: SingleChildScrollView(
                                          child: Consumer<AdminProviders>(
                                              builder: (context, value,
                                                      child) =>
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                    children: value.categories
                                                        .map((e) => TextButton(
                                                            onPressed: () {
                                                              provider
                                                                  .categoriesController
                                                                  .text = e["name"];
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                                e["name"],style:const TextStyle(color: blackColor),)))
                                                        .toList(),
                                                  )),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                      },
                    ),
                    smallSpacing,
                    TextFormField(
                      controller: provider.discriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    smallSpacing,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Select Size ',
                          style: TextStyle(
                              color: blackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    const SizeSelectingDialog());
                          },
                        )
                      ],
                    ),
                    const Divider(
                      color: greyColor,
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
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    size,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : const SizedBox(),
                    smallSpacing,
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  const ColorSelectingDialog());
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            provider.pickImagesAndUpload();
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: blackColor,
                            size: 40,
                          ),
                        ),
                        const Text('Pick Image'),
                        const SizedBox(height: 10),
                      ],
                    ),
                    provider.isLoading
                        ? const CircularProgressIndicator()
                        : imageUrls.isNotEmpty
                            ? GalleryImage(
                                numOfShowImages:
                                    imageUrls.length < 3 ? imageUrls.length : 3,
                                imageUrls: imageUrls)
                            : const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  'No images uploaded yet',
                                  style: TextStyle(color: greyColor),
                                ),
                              ),
                    smallSpacing,
                    CustomButton(
                        text: isUpdating ? 'Submit' : 'Add',
                        onPressed: () {
                          provider.handleSubmit(
                              context, isUpdating, isUpdating ? id! : "");
                        })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
