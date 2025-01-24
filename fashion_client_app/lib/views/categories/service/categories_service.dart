import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/categories_model.dart';

class CategoriesService {
  /// Fetch categories from the database
  Stream<List<CategoriesModel>> fetchCategories() {
    return DbService().readCategories().map((snapshot) {
      return CategoriesModel.fromJsonList(snapshot.docs);
    });
  }

  /// Filter categories by type
  List<CategoriesModel> filterCategoriesByType(
      List<CategoriesModel> categories, String type) {
    return categories.where((category) => category.type == type).toList();
  }
}