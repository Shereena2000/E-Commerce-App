import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/products_model.dart';


class ProductService {
  Stream<List<ProductModels>> fetchProductsByCategory(
    String category, {
    List<String> selectedSize = const [],
    List<String> selectedColor = const [],
    List<String> selectedPriceRange = const [],
  }) {
    return DbService().readProducts().map((snapshot) {
      final products = ProductModels.fromJsonList(snapshot.docs);
      
      return products.where((product) {
        // Always filter by category first
        if (product.category != category) return false;

        // Size filter
        if (selectedSize.isNotEmpty &&
            !product.sizeVariants.any((size) => selectedSize.contains(size))) {
          return false;
        }

        // Color filter
        if (selectedColor.isNotEmpty &&
            !product.colorVariants.any((color) => selectedColor.contains(color))) {
          return false;
        }

        // Price range filter
        if (selectedPriceRange.isNotEmpty) {
          bool matchesPriceRange = false;
          for (final range in selectedPriceRange) {
            final (min, max) = _parsePriceRange(range);
            if (product.newPrice >= min && product.newPrice <= max) {
              matchesPriceRange = true;
              break;
            }
          }
          if (!matchesPriceRange) return false;
        }

        return true;
      }).toList();
    });
  }

  // Helper function to convert price range strings to numerical values
  (double min, double max) _parsePriceRange(String range) {
    switch (range) {
      case "Below ₹500":
        return (0, 500);
      case "₹500 - ₹1,000":
        return (500, 1000);
      case "₹1,000 - ₹2,500":
        return (1000, 2500);
      case "₹2,500 - ₹5,000":
        return (2500, 5000);
      case "₹5,000 - ₹10,000":
        return (5000, 10000);
      case "Above ₹10,000":
        return (10000, double.infinity);
      default:
        return (0, 0);
    }
  }
}