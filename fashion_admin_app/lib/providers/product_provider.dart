import 'package:fashion_admin_app/controllers/cloudinary_service.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/models/product_models.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController oldPriceController = TextEditingController();
  TextEditingController newPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController imageUrlsController = TextEditingController();
  List<XFile>? selectedImages = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<String> _selectedSize = [];
  List<String> _selectedColors = [];

  List<String> get selectedSize => _selectedSize;
  List<String> get selectedColors => _selectedColors;

  void initializeForm({
    required String name,
    required String oldPrice,
    required String newPrice,
    required String quantity,
    required String category,
    required String description,
    required List<String> sizeVariants,
    required List<String> colorVariants,
    required List<String> imageUrls,
  }) {
    nameController.text = name;
    oldPriceController.text = oldPrice;
    newPriceController.text = newPrice;
    quantityController.text = quantity;
    categoriesController.text = category;
    discriptionController.text = description;
    _selectedSize = sizeVariants;
    _selectedColors = colorVariants;

    // Initialize image URLs
    imageUrlsController.text = imageUrls.join(',');

    notifyListeners();
  }

  void setSelectedSize(List<String> selectedSize) {
    _selectedSize = selectedSize;
    notifyListeners();
  }

  void toggleSize(String size) {
    if (_selectedSize.contains(size)) {
      _selectedSize.remove(size);
    } else {
      _selectedSize.add(size);
    }
    notifyListeners();
  }

  void toggleColor(String color) {
    if (_selectedColors.contains(color)) {
      _selectedColors.remove(color);
    } else {
      _selectedColors.add(color);
    }
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

//validation size
  bool validateSize(BuildContext context) {
    if (_selectedSize.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select at least one size.")));
      return false;
    }
    return true;
  }

  //clear values
  void clearForm() {
    nameController.clear();
    oldPriceController.clear();
    newPriceController.clear();
    quantityController.clear();
    categoriesController.clear();
    discriptionController.clear();
    imageUrlsController.clear();
    _selectedSize = [];
    _selectedColors = [];
    notifyListeners();
  }

//
  void updateProductDetails(ProductModels product) {
    nameController.text = product.name;
    oldPriceController.text = product.oldPrice.toString();
    newPriceController.text = product.newPrice.toString();
    quantityController.text = product.maxQuantity.toString();
    categoriesController.text = product.category;
    discriptionController.text = product.description;
    _selectedSize = product.sizeVariants;
    _selectedColors = product.colorVariants;
    imageUrlsController.text = product.images.join(',');
    notifyListeners();
  }

//validation color
  bool validateColor(BuildContext context) {
    if (_selectedColors.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select at least one color.")));
      return false;
    }
    return true;
  }

//image vallidation
  bool validateImage(BuildContext context) {
    if (imageUrlsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please upload at least one image.")));
      return false;
    }
    return true;
  }

  Future<void> pickImagesAndUpload() async {
    final picker = ImagePicker();
    try {
      final selectedImages = await picker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        setLoading(true);
        List<String?> imageUrls = [];
        for (var image in selectedImages) {
          String? imageUrl = await uploadToCloudinary(image);
          if (imageUrl != null) {
            imageUrls.add(imageUrl); // Add the uploaded image URL to the list
          }
        }
        imageUrlsController.text = imageUrls.join(
            ','); // Example of joining image URLs as a comma-separated string

        print("Uploaded Images: $imageUrls");
        notifyListeners();
      }
    } catch (e) {
      print('Error picking images: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> handleSubmit(
      BuildContext context, bool isUpdating, String productId) async {
    if (formKey.currentState!.validate() &&
        validateSize(context) &&
        validateColor(context) &&
        validateImage(context)) {
      if (isUpdating) {
        await DbService().updateProducts(doId: productId, data: {
          "name": nameController.text,
          "oldPrice": int.parse(oldPriceController.text),
          "newPrice": int.parse(newPriceController.text),
          "maxQuantity": int.parse(quantityController.text),
          "category": categoriesController.text,
          "description": discriptionController.text,
          "sizeVariants": selectedSize,
          "colorVariants": selectedColors,
          "images": imageUrlsController.text.split(','),
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Product Updated")));
      } else {
        await DbService().createProducts(data: {
          "name": nameController.text,
          "oldPrice": int.parse(oldPriceController.text),
          "newPrice": int.parse(newPriceController.text),
          "maxQuantity": int.parse(quantityController.text),
          "category": categoriesController.text,
          "description": discriptionController.text,
          "sizeVariants": selectedSize,
          "colorVariants": selectedColors,
          "images": imageUrlsController.text.split(','),
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Product Added")));
      }
      clearForm();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please provide details")));
    }
    Navigator.of(context).pop();
  }
}
