import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/controllers/cloudinary_service.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PromoProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  String selectedValue = "Women";
  XFile? image;
  void initializeForm({
    required String title,
    required String subTitle,
    required String imageUrl,
    required String promoCategory,
  }) {
    titleController.text = title;
    subTitleController.text = subTitle;
    imageController.text = imageUrl;

    selectedValue = promoCategory;
    notifyListeners();
  }

  Future<void> pickImageAndUpload(BuildContext context) async {
    final picker = ImagePicker();
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        String? imageUrl = await uploadToCloudinary(image);
        if (imageUrl != null && imageUrl.isNotEmpty) {
          imageController.text = imageUrl;
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image uploaded successfully!'),
              backgroundColor: colorTheme,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image upload failed. Please try again.'),
              backgroundColor: colorTheme,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> handleSubmit(
      BuildContext context, bool isUpdating, String promoId) async {
    if (formKey.currentState!.validate()) {
      if (isUpdating) {
        await DbService().updatePromos(
          docId: promoId,
          data: {
            "title": titleController.text,
            "subTitle": subTitleController.text,
            "image": imageController.text,
            "category": selectedValue,
          },
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Promo Updated")));
      } else {
        await DbService().createPromos(
          data: {
            "title": titleController.text,
            "subTitle": subTitleController.text,
            "image": imageController.text,
            "category": selectedValue,
          },
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Promo Added")));
      }
      Navigator.of(context).pop();
    }
  }
}
