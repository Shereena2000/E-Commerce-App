import 'dart:io';

import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/controllers/cloudinary_service.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddAndModifyCategory extends StatefulWidget {
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
  State<AddAndModifyCategory> createState() => _AddAndModifyCategoryState();
}

class _AddAndModifyCategoryState extends State<AddAndModifyCategory> {
  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  late XFile? image = null;
  TextEditingController categoryController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  String selectedValue ='Women';
 

  void _pickImageAndCloudinaryUpload() async {
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print('Error picking image: $e');
    }
    if (image != null) {
      String? res = await uploadToCloudinary(image);
      setState(
        () {
          if (res != null) {
            imageController.text = res;
            print("set image url $res : ${imageController.text}");
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Image uploaded successfully")));
          }
        },
      );
    }
  }

  handleSubmit() async {
    if (formKey.currentState!.validate()) {
      if (widget.isUpdating) {
        await DbService().updateCategoris(doId: widget.categoryId, data: {
          "name": categoryController.text,
          "priority": int.parse(priorityController.text),
          "image": imageController.text,
          "type": selectedValue,
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Category Updated")));
      } else {
        await DbService().createCategories(data: {
          "name": categoryController.text,
          "image": imageController.text,
          "priority": int.parse(priorityController.text),
          "type": selectedValue,
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Category Added")));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.isUpdating && widget.name != null) {
      categoryController.text = widget.name!;
      imageController.text = widget.image!;
      priorityController.text = widget.priority.toString();
      selectedValue = widget.type!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      title: Center(
        child: Text(widget.isUpdating ? "Update Category" : "Add Category"),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    _pickImageAndCloudinaryUpload();
                  },
                  child: image == null
                      ? imageController.text.isNotEmpty
                          ? Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.network(
                                imageController.text,
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
                            File(image!.path),
                            fit: BoxFit.contain,
                          ))),
              moderateSpacing,
              TextFormField(
                controller: categoryController,
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
                controller: priorityController,
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
                value: selectedValue,
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
                  setState(() {
                    if (newValue != null) {
                      selectedValue = newValue;
                    }
                  });
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
            child: Text("Cancel"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            )),
        ElevatedButton(
          onPressed: handleSubmit,
          child: Text(widget.isUpdating ? "Update" : "Add"),
        ),
      ],
    );
  }
}
