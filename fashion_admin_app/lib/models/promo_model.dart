import 'package:cloud_firestore/cloud_firestore.dart';

class PromoModel {
  String id;
  String title;
  String subTitle;
  String imageUrl;
  String category;

  PromoModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.category,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json, String id) {
    return PromoModel(
      id: id,
      title: json["title"] ?? " ",
      subTitle: json["subTitle"] ?? " ",
      imageUrl: json["image"] ?? " ",
      category: json["category"] ?? " ",
    );
  }
  static List<PromoModel> fromJsonList(List<QueryDocumentSnapshot> list) {
    return list
        .map((e) => PromoModel.fromJson(e.data() as Map<String, dynamic>, e.id))
        .toList();
  }
}
