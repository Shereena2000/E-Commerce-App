import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/products_model.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final Map<String, bool> _favoriteStatus = {};
  final DbService _dbService = DbService();
  final List<ProductModels> _wishlistProducts = [];
  bool _isLoading = false;
  List<ProductModels> get wishlistProducts => _wishlistProducts;
  bool get isLoading => _isLoading;
  WishlistProvider() {
    _initializeWishlist();
  }

  Future<void> _initializeWishlist() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Listen to wishlist changes
      _dbService.readWishlist().listen((wishlistSnapshot) async {
        // Get product IDs from wishlist
        final productIds = wishlistSnapshot.docs
            .map((doc) => doc.get('product_id') as String)
            .toList();

        // Update favorite status
        _favoriteStatus.clear();
        for (final id in productIds) {
          _favoriteStatus[id] = true;
        }

        // Fetch product details if there are products in wishlist
        if (productIds.isNotEmpty) {
          final productsSnapshot =
              await _dbService.searchProducts(productIds).first;
          _wishlistProducts.clear();
          _wishlistProducts
              .addAll(ProductModels.fromJsonList(productsSnapshot.docs));
        } else {
          _wishlistProducts.clear();
        }

        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print("Error initializing wishlist: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isFavorite(String productId) {
    return _favoriteStatus[productId] ?? false;
  }

  void updateFavorite(String productId) {
    _favoriteStatus[productId] = !isFavorite(productId);
    notifyListeners();
  }

  Future<void> addAndRemoveWishlist(String productId) async {
    try {
      if (isFavorite(productId)) {
        await _dbService.addToWishlist(productId: productId);
      } else {
        await _dbService.deleteItemFromWishlist(productId: productId);
      }
    } catch (e) {
      print("Error updating wishlist: $e");
      // Revert the UI state if the Firestore operation fails
      _favoriteStatus[productId] = !isFavorite(productId);
      notifyListeners();
    }
  }
}
