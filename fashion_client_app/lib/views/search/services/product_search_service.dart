
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/model/products_model.dart';

class ProductSearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ProductModels>> searchProducts(
    String query, {
    required List<String> selectedSize,
    required List<String> selectedColor,
    required List<String> selectedPriceRange,
  }) {
    return _firestore
        .collection('shop_products')
        .snapshots()
        .map((snapshot) {
          final products = ProductModels.fromJsonList(snapshot.docs);
          return products.where((product) {
            // Check search query
            bool matchesQuery = query.isEmpty ||
                product.name.toLowerCase().contains(query.toLowerCase());

            // Check selected sizes
            bool matchesSize = selectedSize.isEmpty ||
                (product.sizeVariants.any((s) => selectedSize.contains(s)));

            // Check selected colors
            bool matchesColor = selectedColor.isEmpty ||
                (product.colorVariants.any((c) => selectedColor.contains(c)));

            // Check selected price ranges
            bool matchesPrice = selectedPriceRange.isEmpty ||
                selectedPriceRange.any((range) => _isPriceInRange(product.newPrice, range));

            return matchesQuery && matchesSize && matchesColor && matchesPrice;
          }).toList();
        });
  }

  // Helper to check price range
  bool _isPriceInRange(int price, String range) {
    if (range == "Below ₹500") return price < 500;
    if (range == "₹500 - ₹1,000") return price >= 500 && price <= 1000;
    if (range == "₹1,000 - ₹2,500") return price >= 1000 && price <= 2500;
    if (range == "₹2,500 - ₹5,000") return price >= 2500 && price <= 5000;
    if (range == "₹5,000 - ₹10,000") return price >= 5000 && price <= 10000;
    if (range == "Above ₹10,000") return price > 10000;
    return false;
  }
}