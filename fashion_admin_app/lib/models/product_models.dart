import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModels {
  String name;
  String description;
  List<String> images;
  int oldPrice;
  int newPrice;
  String category;
  String id;
  int maxQuantity;
  List<String> colorVariants;
  List<String> sizeVariants;
  ProductModels({
    required this.name,
    required this.description,
    required this.images,
    required this.oldPrice,
    required this.newPrice,
    required this.category,
    required this.id,
    required this.maxQuantity,
    required this.colorVariants,
    required this.sizeVariants,
  });

  factory ProductModels.fromJson(Map<String, dynamic> json, String id) {
    print("Parsed newPrice: ${json["new_price"]}");
    return ProductModels(
      name: json["name"] ?? "",
      description: json["description"] ?? "no description",
      images: List<String>.from(json["images"] ?? []),
      oldPrice: json["oldPrice"] ?? 0,
      newPrice: json["newPrice"] ?? 0,
      category: json["category"] ?? "",
      id: id,
      maxQuantity: json["maxQuantity"] ?? 0,
      colorVariants: List<String>.from(json["colorVariants"] ?? []),
      sizeVariants: List<String>.from(json["sizeVariants"] ?? []),
    );
  }

  static List<ProductModels> fromJsonList(List<QueryDocumentSnapshot> list) {
    return list
        .map((e) =>
            ProductModels.fromJson(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }
}
