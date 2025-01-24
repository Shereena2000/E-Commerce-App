import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  String id, name, image, type;
  int priority;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.image,
    required this.priority,
    required this.type,
  });

  // Convert JSON to CategoriesModel
  factory CategoriesModel.fromJson(Map<String, dynamic> json, String id) {
    return CategoriesModel(
      id: id,
      name: json["name"] ?? " ",
      image: json["image"] ?? " ",
      priority: json["priority"] ?? 0,
      type: json["type"] ?? " ",
    );
  }

  // Convert List<QueryDocumentSnapshot> to List<CategoriesModel>
  static List<CategoriesModel> fromJsonList(List<QueryDocumentSnapshot> list) {
    return list.map((e) => CategoriesModel.fromJson(e.data() as Map<String, dynamic>, e.id)).toList();
  }
}
