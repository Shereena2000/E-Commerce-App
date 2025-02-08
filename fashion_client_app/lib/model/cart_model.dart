import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String cartId;
  final String productId;
  final String size;
  final String color;
  int quantity;

  CartModel({
    required this.cartId,
    required this.productId,
    required this.size,
    required this.color,
    required this.quantity,
  });

  // Convert JSON to CartModel object
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: json["cart_id"] ?? "",
      productId: json["product_id"] ?? "",
      size: json["size"] ?? "",
      color: json["color"] ?? "",
      quantity: json["quantity"] ?? 0,
    );
  }

  // Convert a list of QueryDocumentSnapshot to a list of CartModel
  static List<CartModel> fromJsonList(List<QueryDocumentSnapshot> list) {
    return list.map((e) => CartModel.fromJson(e.data() as Map<String, dynamic>)).toList();
  }

  // Convert CartModel object to JSON (for storing in Firestore)
  Map<String, dynamic> toJson() {
    return {
      "cart_id": cartId,
      "product_id": productId,
      "size": size,
      "color": color,
      "quantity": quantity,
    };
  }
}
