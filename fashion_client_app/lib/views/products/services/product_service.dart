import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/products_model.dart';

class ProductService {
   Stream<List<ProductModels>> fetchProductsByCategory(String category) {
    return DbService().readProducts().map((snapshot) {
      final products = ProductModels.fromJsonList(snapshot.docs);
      return products.where((product) => product.category == category).toList();
    });
  }
}
