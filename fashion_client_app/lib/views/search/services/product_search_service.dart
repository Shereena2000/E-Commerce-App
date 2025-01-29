import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/model/products_model.dart';

class ProductSearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch products based on search query
  // Stream<List<ProductModels>> searchProducts(String query) {
  //   if (query.isEmpty) {
  //     return Stream.value([]); // Return an empty list
  //   }
  //   return _firestore
  //       .collection('shop_products')
  //       .where('name', isGreaterThanOrEqualTo: query)
  //       .where('name', isLessThanOrEqualTo: '${query}\uf8ff')
  //       .snapshots()
  //       .map((snapshot) { print("************");
  //         print("Number of documents returned: ${snapshot.docs.length}");
  //     return ProductModels.fromJsonList(snapshot.docs);
  //   });
  // }
  Stream<List<ProductModels>> searchProducts(String query) {
  if (query.isEmpty) {
    return Stream.value([]);
  }
  return _firestore
      .collection('shop_products')
      .snapshots()
      .map((snapshot) {
        // Filter products on the client side
        return ProductModels.fromJsonList(snapshot.docs).where((product) {
          return product.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
}
}
