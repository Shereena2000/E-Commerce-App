import 'package:fashion_admin_app/controllers/cloudinary_service.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoryProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  String selectedValue = 'Women';
  XFile? image;
  

  // Used to initialize the form when updating a category
  void initializeForm({
    required String name,
    required String imageUrl,
    required int priority,
    required String type,
  }) {
    categoryController.text = name;
    imageController.text = imageUrl;
    priorityController.text = priority.toString();
    selectedValue = type;
    notifyListeners();
  }

  // Pick image and upload to cloudinary
  Future<void> pickImageAndUpload() async {
    final picker = ImagePicker();
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // Upload image to Cloudinary or any service
        String? imageUrl = await uploadToCloudinary(image);
        imageController.text = imageUrl ?? '';
        notifyListeners();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Handle form submission (Add or Update category)
  Future<void> handleSubmit(
      BuildContext context, bool isUpdating, String categoryId) async {
    if (formKey.currentState!.validate()) {
      if (isUpdating) {
        await DbService().updateCategoris(
          doId: categoryId,
          data: {
            "name": categoryController.text,
            "priority": int.parse(priorityController.text),
            "image": imageController.text,
            "type": selectedValue,
          },
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Category Updated")));
      } else {
        await DbService().createCategories(
          data: {
            "name": categoryController.text,
            "image": imageController.text,
            "priority": int.parse(priorityController.text),
            "type": selectedValue,
          },
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Category Added")));
      }
      Navigator.of(context).pop();
    }
  }
}
