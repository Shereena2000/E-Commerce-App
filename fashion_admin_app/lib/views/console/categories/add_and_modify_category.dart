import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/providers/category_provider.dart';
import 'package:fashion_admin_app/views/console/categories/widgets/category_drop_down.dart';
import 'package:fashion_admin_app/views/console/categories/widgets/category_name_field.dart';
import 'package:fashion_admin_app/views/console/categories/widgets/image_picker_widget.dart';
import 'package:fashion_admin_app/views/console/categories/widgets/priority_field.dart';
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
                type: type ??" Women's Western Wear",
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
                    ImagePickerWidget(provider: provider,),
                    moderateSpacing,
                    CategoryNameField(provider: provider,),
                    moderateSpacing,
                    PriorityField(provider: provider,),
                    moderateSpacing,
                    CategoryDropDown(
                      selectedValue: provider.selectedValue,
                      onChanged: (String? newValue) {
                         if (newValue != null) {
                          provider.selectedValue = newValue;
                        }
                      },
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

