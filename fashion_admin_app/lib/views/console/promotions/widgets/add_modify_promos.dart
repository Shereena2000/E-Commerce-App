import 'dart:io';
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/providers/promo_provider.dart';
import 'package:fashion_admin_app/utils/app_utils.dart';
import 'package:fashion_admin_app/utils/form_validator.dart';
import 'package:fashion_admin_app/widgets/custom_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddModifyPromos extends StatelessWidget {
  final bool isUpdating;
  final String? title;
  final String? subTitle;
  final String promoId;
  final String? image;
  final String? promoCategory;
  const AddModifyPromos({
    super.key,
    required this.isUpdating,
    this.title,
    required this.promoId,
    this.image,
    this.promoCategory,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PromoProvider(),
      child: Consumer<PromoProvider>(builder: (context, promoProvider, child) {
        if (promoProvider.titleController.text.isEmpty && isUpdating) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            promoProvider.initializeForm(
                title: title ?? '',
                subTitle: subTitle ?? '',
                imageUrl: image ?? '',
                promoCategory: promoCategory ?? "Women");
          });
        }
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Center(
            child: Text(isUpdating ? "Update Promos" : "Add Promos"),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: promoProvider.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      promoProvider.pickImageAndUpload(context);
                    },
                    child: promoProvider.image != null
                        ? Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                              border: Border.all(color: colorTheme),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.file(
                              File(promoProvider.image!.path),
                              fit: BoxFit.contain,
                            ),
                          )
                        : promoProvider.imageController.text.isNotEmpty
                            ? Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  border: Border.all(color: colorTheme),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.network(
                                  promoProvider.imageController.text,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                    child: Icon(Icons.broken_image,
                                        size: 50, color: Colors.red),
                                  ),
                                ),
                              )
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
                              ),
                  ),
                  moderateSpacing,
                  CustomTextFormFeild(
                    icon: Icons.edit_outlined,
                    hint: "Title",
                    label: "Title",
                    controller: promoProvider.titleController,
                    validator: (value) => validateNotEmpty(value),
                  ),
                  moderateSpacing,
                  CustomTextFormFeild(
                    icon: Icons.title_outlined,
                    hint: "Sub Title",
                    label: "Sub Title",
                    controller: promoProvider.subTitleController,
                    validator: (value) => validateNotEmpty(value),
                  ),
                  DropdownButtonFormField<String>(
                    value: promoProvider.selectedValue,
                    hint: const Text("Select a type"),
                    items: promoCategoryTitle.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        promoProvider.selectedValue = newValue;
                      }
                    },
                    validator: (value) =>
                        value == null ? "Please select a type" : null,
                  )
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
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                promoProvider.handleSubmit(context, isUpdating, promoId);
              },
              child: Text(isUpdating ? "Update" : "Add"),
            ),
          ],
        );
      }),
    );
  }
}
