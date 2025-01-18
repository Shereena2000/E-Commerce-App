import 'dart:io';

import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAndModifyCategory extends StatelessWidget {
  final bool isUpdating;
  final String? name;
  final String categoryId;
  final String? image;
  final String? type;
  final int priority;

  const AddAndModifyCategory({
    super.key,
    required this.isUpdating,
    this.name,
    required this.categoryId,
    this.image,
    required this.priority,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryProvider(),
      child: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          // Initialize the form only after the widget is built to avoid the error
          if (provider.categoryController.text.isEmpty && isUpdating) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.initializeForm(
                name: name ?? '',
                imageUrl: image ?? '',
                priority: priority,
                type: type ?? 'Women',
              );
            });
          }

          return AlertDialog(
            backgroundColor: whiteColor,
            title: Center(
              child: Text(isUpdating ? "Update Category" : "Add Category"),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: provider.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        provider.pickImageAndUpload();
                      },
                      child: provider.image == null
                          ? provider.imageController.text.isNotEmpty
                              ? Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.network(
                                    provider.imageController.text,
                                    fit: BoxFit.contain,
                                  ))
                              : Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: colorTheme),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.image,
                                          size: 60, color: colorTheme),
                                      Text('Pick Image'),
                                    ],
                                  ),
                                )
                          : Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.file(
                                File(provider.image!.path),
                                fit: BoxFit.contain,
                              ),
                            ),
                    ),
                    moderateSpacing,
                    TextFormField(
                      controller: provider.categoryController,
                      validator: (value) =>
                          value!.isEmpty ? "This field cannot be empty" : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Category Name',
                        labelText: 'Category Name',
                      ),
                    ),
                    moderateSpacing,
                    TextFormField(
                      controller: provider.priorityController,
                      validator: (value) => value!.isEmpty
                          ? "This field cannot be empty"
                          : int.tryParse(value) == null
                              ? "Enter a valid number"
                              : null,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Priority',
                        labelText: 'Priority',
                      ),
                    ),
                    moderateSpacing,
                    DropdownButtonFormField<String>(
                      value: provider.selectedValue,
                      hint: const Text("Select a type"),
                      items: [
                        'Women',
                        'Men',
                        'Infants',
                        'Boys',
                        'Girls',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          provider.selectedValue = newValue;
                        }
                      },
                      validator: (value) =>
                          value == null ? "Please select a type" : null,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
               
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),   child:const Text("Cancel"),),
              ElevatedButton(
                onPressed: () {
                  provider.handleSubmit(context, isUpdating, categoryId);
                },
                child: Text(isUpdating ? "Update" : "Add"),
              ),
            ],
          );
        },
      ),
    );
  }
}
